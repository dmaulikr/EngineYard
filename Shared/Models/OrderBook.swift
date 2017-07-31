//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

typealias FulfiledOrder = CompletedOrder
typealias CustomerBase = CompletedOrder

protocol EntryProtocol {
    var value: Int { get set }
}

enum OrderBookEntryType {
    case existingOrder
    case completedOrder
}

// Orders are array of [Int] and can be existingOrder or completedOrder
final class OrderBook {
    public fileprivate(set) weak var parent: Train?
    var existingOrders: [ExistingOrder] = [ExistingOrder]()
    var completedOrders: [CompletedOrder] = [CompletedOrder]()

    init(parent: Train) {
        self.parent = parent
    }

    func clear() {
        self.existingOrders.removeAll()
        self.completedOrders.removeAll()
    }

    func add<C1: Any>(order: C1) where C1: EntryProtocol {

        if let existingOrderObj = order as? ExistingOrder {
            if (self.canAddToExistingOrders()) {
                self.existingOrders.append(existingOrderObj)
            }
        }

        if let compOrder = order as? CompletedOrder {
            if (self.canAddToCompletedOrders()) {
                self.completedOrders.append(compOrder)
            }
        }
    }

    func canAddToExistingOrders() -> Bool {
        guard let hasParent = self.parent else {
            return false
        }
        if (self.existingOrders.count == hasParent.capacity) {
            return false
        }
        if ((self.existingOrders.count + 1) > hasParent.capacity) {
            return false
        }
        return true
    }

    func canAddToCompletedOrders() -> Bool {
        guard let hasParent = self.parent else {
            return false
        }
        if (self.completedOrders.count == hasParent.capacity) {
            return false
        }
        if ((self.completedOrders.count + 1) > hasParent.capacity) {
            return false
        }
        return true
    }


    func generateExistingOrders(howMany: Int) {
        guard let train = self.parent else {
            assertionFailure("No train provided")
            return
        }

        if self.canGenerateExistingOrders(howMany: howMany, forTrain: train) {
            for _ in 1...howMany {
                let orderObj: ExistingOrder = ExistingOrder.generate()
                train.orderBook.add(order: orderObj)
            }
        }
    }

    internal func canGenerateExistingOrders(howMany: Int, forTrain: Train) -> Bool {
        guard forTrain.capacity > 0 else {
            assertionFailure("Capacity must > 0")
            return false
        }
        if howMany <= 0 {
            assertionFailure("Generate must > 0")
            return false
        }
        if howMany > forTrain.capacity {
            assertionFailure("Cannot exceed orders capacity .1")
            return false
        }
        if ((forTrain.existingOrders.count + howMany) > forTrain.capacity) {
            assertionFailure("Cannot exceed orders capacity .2")
            return false
        }
        return true
    }


    // transfer die value from X -> Y
    // if destination = completedOrder, move value from existingOrders -> customerBase
    // if destination = existingOrders, move value from customerBase -> existingOrders
    //

    func transferOrder<C1: Any>(order: C1, index: Int) where C1: EntryProtocol
    {
        // move: existingOrder -> completedOrder
        if let existingOrder = order as? ExistingOrder {
            print ("Transferring \(existingOrder.description), FROM existingOrders -> completedOrders\n")

            let orderObj: CompletedOrder = CompletedOrder.init(value: existingOrder.value)

            self.completedOrders.append(orderObj)
            self.existingOrders.remove(at: index)
        }
        else if let completedOrder = order as? CompletedOrder {
            // move: completedOrder -> existingOrder
            print ("Transferring \(completedOrder.description), FROM completedOrders -> existingOrders ->\n")

            let orderObj: ExistingOrder = ExistingOrder.init(value: completedOrder.value)

            self.existingOrders.append(orderObj)
            self.completedOrders.remove(at: index)
        }
    }

    // Remove first value from completedOrder
    // If no value is found; remove the lowest numbered value in orders
    func removeFirstValueFromCompletedOrder() {
        if (self.completedOrders.count == 0) {

            // remove the value from existing orders instead
            guard self.existingOrders.count > 0 else {
                print ("existingOrders are empty")
                return
            }

            let sortedElementsAndIndices = self.existingOrders.enumerated().sorted(by: {
                $0.element.value < $1.element.value
            })

            guard let firstItem = sortedElementsAndIndices.first else {
                return
            }

            self.existingOrders.remove(at: firstItem.0)
        }
        else {
            self.completedOrders.removeFirst()
        }
    }

    func reduceExistingOrderValueAtIndex(index:Int, byValue:Int) -> Int? {
        guard self.existingOrders.count > 0 else {
            return nil
        }

        var transfer = false
        let existingOrderObj = self.existingOrders[index]
        existingOrderObj.value -= byValue

        if (existingOrderObj.value <= 0) {
            existingOrderObj.value = 0
            transfer = true
        }

        self.existingOrders[index] = existingOrderObj

        if (transfer == true) {
            self.transferOrder(order: existingOrderObj, index: index)
        }

        return existingOrderObj.value
    }

    func rerollAndTransferCompletedOrders() {
        guard self.completedOrders.count > 0 else {
            print ("completedOrders are empty")
            return
        }
        for (index, item) in self.completedOrders.enumerated().reversed() {
            item.value = Die.roll()
            self.transferOrder(order: item, index: index)
        }
    }
}

class ExistingOrder: EntryProtocol, CustomStringConvertible {
    var value : Int = 0

    var description: String {
        return String(self.value)
    }

    init(value: Int) {
        self.value = value
    }

    public static func generate() -> ExistingOrder {
        return ExistingOrder.init(value: Die.roll())
    }
}

class CompletedOrder: EntryProtocol, CustomStringConvertible {
    var value : Int = 0

    var description: String {
        return String(self.value)
    }
    
    init(value: Int) {
        self.value = value
    }
    
    public static func generate() -> CompletedOrder {
        return CompletedOrder.init(value: Die.roll())
    }
}


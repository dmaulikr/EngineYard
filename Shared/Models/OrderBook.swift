//
//  OrderBook.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation


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
    public fileprivate(set) weak var parent: Locomotive?
    var existingOrders: [ExistingOrder] = [ExistingOrder]()
    var completedOrders: [CompletedOrder] = [CompletedOrder]()

    init(parent: Locomotive) {
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
        return false
    }


    func generateExistingOrders(howMany: Int) {
        guard let forTrain = self.parent else {
            assertionFailure("No train provided")
            return
        }
        guard forTrain.capacity > 0 else {
            assertionFailure("Capacity must > 0")
            return
        }
        if howMany <= 0 {
            assertionFailure("Generate must > 0")
            return
        }
        if howMany > forTrain.capacity {
            assertionFailure("Cannot exceed orders capacity .1")
            return
        }
        if ((forTrain.existingOrders.count + howMany) > forTrain.capacity) {
            assertionFailure("Cannot exceed orders capacity .2")
            return
        }

        for _ in 1...howMany {
            let orderObj: ExistingOrder = ExistingOrder.generate()
            forTrain.orderBook.add(order: orderObj)
        }
    }


    // transfer die value from X -> Y
    // if destination = completedOrder, move value from existingOrders -> customerBase
    // if destination = existingOrders, move value from customerBase -> existingOrders
    //
    func transfer(index: Int, destination: OrderBookEntryType) {
        switch destination {
        case .existingOrder: // move -> completedOrders
            guard self.completedOrders.count > 0 else {
                print ("completedOrders are empty")
                return
            }

            let customerBaseObj = self.completedOrders[index]

            print ("Transferring index \(index), \(customerBaseObj.value) FROM completedOrders -> existingOrders\n")

            let existingOrderObj = ExistingOrder.init(value: customerBaseObj.value)

            self.existingOrders.append(existingOrderObj)
            self.completedOrders.remove(at: index)
            break

        case .completedOrder: // move -> existingOrders
            guard self.existingOrders.count > 0 else {
                print ("existingOrders are empty")
                return
            }

            let orderObj = self.existingOrders[index] as ExistingOrder

            print ("\nTransferring index: \(index), value: \(orderObj.value) FROM existingOrders -> completedOrders\n")

            let completedOrderObj = CompletedOrder.init(value: orderObj.value)

            self.completedOrders.append(completedOrderObj)
            self.existingOrders.remove(at: index)

            break
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
            self.transfer(index: index, destination: .completedOrder)
        }

        return existingOrderObj.value
    }

    func rerollAndTransferCompletedOrders() {
        guard self.completedOrders.count > 0 else {
            print ("completedOrders are empty")
            return
        }
        for (index, item) in self.completedOrders.enumerated() {
            item.value = Die.roll()
            self.transfer(index: index, destination: .existingOrder)
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
        let order = ExistingOrder.init(value: Die.roll())
        return order
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
}


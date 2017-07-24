//
//  Locomotive.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

import ObjectMapper

typealias Train = Locomotive

protocol LocomotiveProtocol {
    var name: String { get }
    var cost: Int { get }
    var productionCost: Int { get }
    var income: Int { get }
    var generation: Generation { get }
    var engineColor: EngineColor { get }

    var isUnlocked: Bool { get }
    var capacity: Int { get } // capacity of orders, sales array
    var numberOfChildren: Int { get } // how many cards (engines) to create

    var isRusting: Bool { get } // Obsolescence
    var hasRusted: Bool { get } // Obsolescence
}

final class Locomotive : NSObject, LocomotiveProtocol {
    let uuid: String = UUID().uuidString
    public private(set) var name: String = ""
    public private(set) var generation: Generation = .first
    public private(set) var engineColor: EngineColor = .green
    public private(set) var cost: Int = 0
    public private(set) var productionCost: Int = 0
    public private(set) var income: Int = 0

    lazy var orderBook: OrderBook = OrderBook(parent: self) // order book & completedOrders book
    var existingOrders: [Int] {
        return orderBook.existingOrders.flatMap({ (e:ExistingOrder) -> Int in
            return e.value
        })
    }
    var completedOrders: [Int] {
        return orderBook.completedOrders.flatMap({ (c:CompletedOrder) -> Int in
            return c.value
        })
    }

    public private(set) var capacity: Int = 0
    public private(set) var numberOfChildren: Int = 0

    var engines: [Engine] = [Engine]()
    var owners: [Player]? {
        let filtered = self.engines.filter { (eng:Engine) -> Bool in
            return (eng.owner != nil)
            }
            .sorted { (engA:Engine, engB:Engine) -> Bool in
                return ((engA.owner?.turnOrder)! < (engB.owner?.turnOrder)!)
            }.flatMap { (eng:Engine) -> Player? in
                return (eng.owner)
        }

        return filtered
    }

    // # Obsolescence variables
    public fileprivate(set) var isRusting : Bool = false {
        didSet {
            print ("\(self.name) is rusting")
        }
    }
    public fileprivate(set) var hasRusted: Bool = false {
        didSet {
            print ("\(self.name) has rusted - OBSOLETE")
        }
    }

    var isUnlocked: Bool {
        return ((self.existingOrders.count > 0) || (self.completedOrders.count > 0))
    }

    override var description: String {
        var returnString = "Train: \(self.name), orders: \(self.existingOrders), completedOrders: \(self.completedOrders)"
        if (self.isRusting) {
            returnString = returnString.appending(" - OLD -")
        }
        if (self.hasRusted) {
            returnString = returnString.appending(" ** OBSOLETE **")
        }
        if (self.isUnlocked) {
            returnString = returnString.appending(" [Unlocked]")
        }
        returnString = returnString.appending("\(self.cost), \(self.productionCost) \(self.income)")
        return returnString
    }

    // MARK: - Initializer

    init(name:String, cost: Int, generation:Generation, engineColor:EngineColor, capacity:Int, numberOfChildren:Int) {
        super.init()
        assert(cost % 4 == 0, "Cost must be modulus of 4")

        self.name = name
        self.cost = cost
        self.productionCost = Int(cost / 2)
        self.income = Int(productionCost / 2)
        self.generation = generation
        self.engineColor = engineColor
        self.capacity = capacity
        self.numberOfChildren = numberOfChildren

        EngineAPI.createEnginesFor(train: self)
    }

}

extension Locomotive {

    // The maximum number of dice for a locomotive type and generation is determined by the number of boxes in the Customer Base.
    func hasMaximumDice() -> Bool {
        return (self.orderBook.completedOrders.count >= self.capacity)
    }

    func markAsOld() {
        self.isRusting = true
    }

    func markAsObsolete() {
        self.hasRusted = true
    }
}

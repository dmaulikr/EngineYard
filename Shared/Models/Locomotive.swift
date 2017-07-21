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

final class Locomotive : NSObject, LocomotiveProtocol, Mappable {
    public private(set) var uuid: String = UUID().uuidString
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

    public private(set) var isRusting : Bool = false
    public private(set) var hasRusted: Bool = false

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

    //
    // MARK: - ObjectMapper protocol
    //

    required convenience public init?(map: Map) {
        self.init()
    }

    func mapping(map: Map) {
        name <- map["engineid"]
        cost <- map["cost"]
        productionCost <- map["productioncost"]
        income <- map["income"]
        generation <- map["generation"]
        engineColor <- map["enginecolor"]
        capacity <- map["capacity"]
        numberOfChildren <- map["qty"]
        
        EngineAPI.createEnginesFor(train: self)
    }
}

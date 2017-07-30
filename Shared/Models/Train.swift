//
//  Train.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation


protocol TrainProtocol {
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

// One train has many locomotive cards
class Train : NSObject {
    public private(set) var uuid: String = UUID().uuidString
    public private(set) var name: String = ""
    public private(set) var generation: Generation = .first
    public private(set) var engineColor: EngineColor = .green
    public private(set) var cost: Int = 0
    public private(set) var productionCost: Int = 0 {
        if (cost % 4 == 0) {
            return Int(cost / 2)
        }
        return 0
    }
    public private(set) var income: Int = 0

    public private(set) var capacity: Int = 0
    public private(set) var numberOfChildren: Int = 0

    // Obsolescence
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
        //return ((self.existingOrders.count > 0) || (self.completedOrders.count > 0))
        return false
    }

    override var description: String {
        //var returnString = "Train: \(self.name), orders: \(self.existingOrders), completedOrders: \(self.completedOrders)"
        var returnString = "Train: \(self.name)"
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

    init(name:String, generation:Generation, engineColor:EngineColor, capacity:Int, numberOfChildren:Int) {
        super.init()
        self.name = name
        //self.cost = cost
        //self.productionCost = Int(cost / 2)
        //self.income = Int(productionCost / 2)
        self.generation = generation
        self.engineColor = engineColor
        self.capacity = capacity
        self.numberOfChildren = numberOfChildren
    }

    /*
     */

    /**
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
     **/
}

//
//  Train.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Train : CustomStringConvertible, Equatable
{
    public private (set) var name: String = ""
    public private (set) var cost: Int = 0
    public private (set) var productionCost: Int = 0
    public private (set) var income: Int = 0
    public private (set) var generation: Generation = .first
    public private (set) var engineColor: EngineColor = .green
    public private (set) var capacity: Int = 0
    public private (set) var numberOfChildren: Int = 0

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

    var cards: [LocomotiveCard] = [LocomotiveCard]()

    lazy var orderBook: OrderBook = OrderBook(parent: self) // order book & completedOrders book

    var isUnlocked: Bool {
        return ((self.existingOrders.count > 0) || (self.completedOrders.count > 0))
    }


    init(name:String, cost: Int, generation:Generation, engineColor:EngineColor, capacity:Int, numberOfChildren:Int) {
        assert(cost % 4 == 0, "Cost must be a modulus of 4")
        assert(capacity > 0, "Capacity must be > 0")
        assert(numberOfChildren > 0, "Number of children must be > 0")
        self.name = name
        self.cost = cost
        self.productionCost = Int(cost / 2)
        self.income = Int(productionCost / 2)
        self.generation = generation
        self.engineColor = engineColor
        self.capacity = capacity
        self.numberOfChildren = numberOfChildren

        // functional code to map the cards to children
        self.cards += (1...numberOfChildren).map{ _ in LocomotiveCard.init(parent: self) }
    }
}

extension Train {
    var description: String {
        var returnString = "Train: \(self.name) : "
        if (self.isRusting) {
            returnString = returnString.appending(" - OLD -")
        }
        if (self.hasRusted) {
            returnString = returnString.appending(" ** OBSOLETE **")
        }
        returnString = returnString.appending(" Cost: \(self.cost), Production: \(self.productionCost) Income: \(self.income)")
        returnString = returnString.appending(" -- Cards: \(self.cards.count)")
        return returnString
    }

}

extension Train {
    public static func ==(lhs: Train, rhs: Train) -> Bool {
        return (lhs.name == rhs.name)
    }
}

extension Train {
    
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

    // The maximum number of dice for a locomotive type and generation is determined by the number of boxes in the Customer Base.
    //func hasMaximumDice() -> Bool {
    //    return (self.orderBook.completedOrders.count >= self.capacity)
    //}

    var hasMaximumDice: Bool {
        return (self.orderBook.completedOrders.count >= self.capacity)
    }
}

extension Train {
    func markAsOld() {
        self.isRusting = true
    }

    func markAsObsolete() {
        self.hasRusted = true
    }
}

extension Train {

    var owners: [Player]? {
        return self.cards
            .lazy
            .flatMap { card in card.owner.map{ (card: card, owner: $0) } }
            .sorted { $0.owner.turnOrder < $1.owner.turnOrder }
            .map { $0.owner }
    }
    
    func isOwned(by player: Player?) -> Bool {
        return self.cards.contains(where: { $0.isOwned(by: player)} )
    }

}

extension Train {

    

}


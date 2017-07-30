//
//  Train.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Train : NSObject
{
    let uuid: String = UUID().uuidString
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

    override var description: String {
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

    init(name:String, cost: Int, generation:Generation, engineColor:EngineColor, capacity:Int, numberOfChildren:Int) {
        super.init()
        assert(cost % 4 == 0, "Cost must be a modulus of 4")
        self.name = name
        self.cost = cost
        self.productionCost = Int(cost / 2)
        self.income = Int(productionCost / 2)
        self.generation = generation
        self.engineColor = engineColor
        self.capacity = capacity
        self.numberOfChildren = numberOfChildren

        guard let cards = LocomotiveCardAPI.createCardsForTrain(train: self) else {
            assertionFailure("No locomotive cards generated for train: \(self.name)")
            return
        }
        self.cards = cards
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

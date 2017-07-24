//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Production : NSObject {
    fileprivate(set) weak var parent: Engine?
    fileprivate(set) var units : Int = 0 {
        didSet {
            if (units < 0) {
                units = 0
            }
        }
    }
    fileprivate(set) var unitsSpent : Int = 0 {
        didSet {
            if (unitsSpent < 0) {
                unitsSpent = 0
            }
        }
    }
    var cost: Int {
        return self.parent?.parent?.productionCost ?? 0
    }

    override var description: String {
        return ("Production Units - \(self.units) vs spent: \(self.unitsSpent)")
    }

    init(parent: Engine) {
        self.parent = parent
    }
}

extension Production {

    func setDefaultProduction() {
        self.units = 1
    }

    func increase(by:Int) {
        guard by > 0 else {
            return
        }
        self.units += by
    }

    func spend(unitsToSpend:Int = 0) {
        if (canSpend(unitsToSpend: unitsToSpend)) {
            self.unitsSpent += unitsToSpend
            self.units -= unitsToSpend
        }
    }

    func reset() {
        self.units += self.unitsSpent
        self.unitsSpent = 0
    }

    func canSpend(unitsToSpend:Int) -> Bool {
        guard unitsToSpend > 0 else {
            return false
        }
        return ( (self.units - unitsToSpend) >= 0 )
    }

    func setProductionAtZero() {
        self.units = 0
    }
}

// #TODO
// Shift production -
extension Production {

    // [Shift production]
    //
    // A player may shift Production Units from older technology 
    // locomotive cards to newer technology locomotive cards.
    //
    // The amount of production capacity the player may purchase or 
    // shift is not limited – as long as he can pay the costs.
    //
    // A player can only ever shift production up the chain, ie:
    // train A -> train B
    //
    // When shifting production capacities from older technology 
    // cards to newer technology cards, the player simply transfers
    // the Production Unit counters from one locomotive card to 
    // the other. In addition, he must pay the difference 
    // of production costs to the Bank.
    //
    // If – after shifting capacities – a locomotive card has 
    // no Production Units, remove it from play immediately.
    //
    // Filter all trains that I own that have
    //    a. owner = player
    //    b. remove current train/engine from filter
    //    c. remove trains where production > cash


    // build a list of train/engines up the chain from this engine
    func shiftable() -> [Engine]? {

        guard let thisEngine = self.parent else {
            return nil
        }
        guard let thisTrain = thisEngine.parent else {
            return nil
        }
        guard let owner = thisEngine.owner else {
            return nil
        }

        // build portfolio
        let portfolio = owner.engines
            .filter { (eng:Engine) -> Bool in
                return (
                    (eng.owner! == owner) &&
                    (eng.production.units > 0) &&
                    ((eng.parent?.cost)! > thisTrain.cost)
                )
            }
            .sorted { (eng1:Engine, eng2:Engine) -> Bool in
            return (
                (eng1.parent?.cost)! < (eng2.parent?.cost)!
            )
        }

        if (portfolio.count == 0) {
            return nil
        }

        return portfolio
    }

}

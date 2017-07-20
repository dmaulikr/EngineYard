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
        return ( (self.units - units) >= 0 )
    }

    func setProductionAtZero() {
        self.units = 0
    }
}

// #TODO
// Shift production -
extension Production {

    // Shift production
    // - The ability to shift production from one engine card to another that a player owns
    // - Train A -> Train B etc
    //
    // Filter all trains that I own that have
    //    a. owner = player
    //    b. remove current train/engine from filter
    //    c. remove trains where production > cash

    func shiftProduction(units: Int, from: Engine, to: Engine) {

    }

    func canShiftProduction(to: Engine) -> Bool {
        return false
    }

    func willRemoveTrainFromGame(units: Int, from: Engine) -> Bool {
        let sum = (from.production.units - units)
        if (sum == 0) {
            return true
        }
        return false
    }
}

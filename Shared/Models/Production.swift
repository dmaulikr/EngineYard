//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Production: CustomStringConvertible, HandDelegate
{
    weak var parent: LocomotiveCard?

    public fileprivate(set) var units : Int = 0 {
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
        guard let train = self.parent?.parent else {
            return 0
        }
        return train.productionCost
    }


    init(parent: LocomotiveCard) {
        self.parent = parent
    }
}

extension Production {
    var description: String {
        return ("Production Units - \(self.units) vs spent: \(self.unitsSpent)")
    }
}

extension Production {

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

extension Production {

    internal func didAdd(card: LocomotiveCard) {
        self.setDefaultProduction()
    }

    private func setDefaultProduction() {
        self.units = 1
    }
}

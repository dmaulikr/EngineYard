//
//  BuyProductionViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class BuyProductionViewModel : NextStateTransitionProtocol
{
    var game: Game!
    var playerOnTurn: Player = TurnOrderManager.instance.current
    weak var engine: Engine?

    var unitsToPurchase: Int = 0 {
        didSet {
            if (self.unitsToPurchase < 0) {
                self.unitsToPurchase = 0
            }
        }
    }
    var totalCost: Int {
        guard let hasEngine = engine else {
            return 0
        }
        guard let hasTrain = hasEngine.parent else {
            return 0
        }
        return (hasTrain.productionCost * unitsToPurchase)
    }

    func stepperValueDidChange(stepperValue: Int) {
        self.unitsToPurchase = stepperValue
    }

    func purchase() {
        if (playerOnTurn.account.canAfford(amount: self.totalCost)) {

        }
        else {
            if (!playerOnTurn.isAI) {
            }
            else {
                skip()
            }
        }
    }

    // MARK: - NextStateTransitionProtocol

    internal func shouldTransitionToNextState() -> Bool {
        // true: if all turns complete
        return false
    }


    internal func transitionToNextState() {
        
    }
}

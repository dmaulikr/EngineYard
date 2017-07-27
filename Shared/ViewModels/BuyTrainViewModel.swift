//
//  BuyTrainViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

protocol NextStateTransitionProtocol {
    func shouldTransitionToNextState() -> Bool
    func transitionToNextState()
}


class BuyTrainViewModel : NextStateTransitionProtocol
{
    var game: Game?
    var playerOnTurn = TurnOrderManager.instance.current
    weak var selectedTrain: Locomotive?

    init(game: Game) {
        self.game = game
    }

    func buy(train: Locomotive) {

        if (playerOnTurn.isAI == false)
        {
            if (playerOnTurn.account.canAfford(amount: train.cost))
            {

            }
            else {

            }
        }
        else {
            train.purchase(buyer: playerOnTurn)
            //finish turn
        }
    }

    func skip() {
        if (playerOnTurn.isAI == false) {
            // Present are you sure
        }
        else {
            // finish turn
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

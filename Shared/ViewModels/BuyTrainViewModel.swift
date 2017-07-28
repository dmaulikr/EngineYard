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
    weak var game: Game?
    weak var playerOnTurn = TurnOrderManager.instance.current
    weak var selectedTrain: Locomotive?

    init(game: Game) {
        self.game = game
    }

    
    // MARK: - NextStateTransitionProtocol

    internal func shouldTransitionToNextState() -> Bool {
        // true: if all turns complete
        return false
    }


    internal func transitionToNextState() {

    }
}

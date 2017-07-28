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

    lazy var allTrains: [Locomotive]? = {
        guard let hasGame = self.game else {
            return nil
        }

        guard let gameBoard = hasGame.gameBoard else {
            return nil
        }
        guard let currentPlayer = self.playerOnTurn else {
            return nil
        }

        return LocomotiveAPI.allLocomotives(gameBoard: gameBoard)
    }()


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

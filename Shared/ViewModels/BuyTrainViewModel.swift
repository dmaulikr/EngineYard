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
    var didPurchaseTrain: Bool = false

    struct NoTrainBoughtMessage {
        static var title: String = NSLocalizedString("End Turn -- Are you sure?", comment: "No train bought title")
        static var message: String = NSLocalizedString("You didn't buy a train, are you sure you want to end your turn without buying a train?", comment: "No train bought message")
    }

    lazy var trains: [Locomotive]? = {
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

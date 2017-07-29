//
//  BuyProductionViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class ProductionPageViewModel
{
    weak var game: Game?
    lazy var currentPlayer: Player? = {
        guard let hasGame = self.game else {
            return nil
        }
        return hasGame.turnOrderManager.current
    }()

    lazy var allTrains: [Locomotive]? = {
        guard let hasGame = self.game else {
            return nil
        }

        guard let gameBoard = hasGame.gameBoard else {
            return nil
        }

        guard let hasPlayer = self.currentPlayer else {
            return nil
        }

        return LocomotiveAPI.allLocomotives(gameBoard: gameBoard)
    }()

    init(game: Game) {
        self.game = game

        guard let hasGame = self.game else {
            assertionFailure("** No game model defined **")
            return
        }

        guard let _ = hasGame.gameBoard else {
            assertionFailure("** No game board defined **")
            return
        }
    }
}

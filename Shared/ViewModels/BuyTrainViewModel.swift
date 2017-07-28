//
//  BuyTrainViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class BuyTrainViewModel
{
    var game: Game?
    var playerOnTurn = TurnOrderManager.instance.current
    
    lazy var trains: [Locomotive]? = {
        guard let gameObj = self.game else {
            return nil
        }
        guard let gameBoard = gameObj.gameBoard else {
            return nil
        }
        return gameBoard.decks
    }()

    init(game: Game) {
        self.game = game
    }


}

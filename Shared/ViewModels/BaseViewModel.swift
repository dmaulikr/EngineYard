//
//  BaseViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 29/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class BaseViewModel : CustomStringConvertible {
    weak var game: Game?

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

        print (self.description)
    }

    var description: String {
        guard let hasGame = self.game else {
            return "** No game defined **"
        }
        guard let gameBoard = hasGame.gameBoard else {
            return "** No game board defined **"
        }
        return ("\(hasGame.description), decks: \(gameBoard.decks.count)")
        return ""
    }

}

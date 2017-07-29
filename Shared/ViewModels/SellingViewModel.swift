//
//  SellingViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class SellingViewModel
{
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
    }


}

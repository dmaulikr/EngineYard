//
//  WinnerViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class WinnerViewModel
{
    var game: Game!

    init(game: Game) {
        self.game = game
    }

    lazy var playersSortedByCash: [Player] = {
        return PlayerAPI.sortPlayersByHighestCash(players: self.game.players)
    }()

    static var pageTitleText: String {
        return NSLocalizedString("Winner", comment: "Winner page title")
    }
}

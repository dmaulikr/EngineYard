//
//  WinnerViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class WinnerViewModel : BaseViewModel
{
    var players: [Player]?

    override init(game: Game) {
        super.init(game: game)

        guard let sorted = self.playersSortedByHighestCash else {
            return
        }
        self.players = sorted
    }

    lazy var playersSortedByHighestCash: [Player]? = {
        guard let gameObj = self.game else {
            return nil
        }
        return PlayerAPI.sortPlayersByHighestCash(players: gameObj.players)
    }()

    static var pageTitleText: String {
        return NSLocalizedString("Winner", comment: "Winner page title")
    }
}

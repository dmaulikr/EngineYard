//
//  HUDViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 28/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class HUDViewModel {
    weak var game: Game?

    lazy var playersInTurnOrder: [Player]? = {
        guard let hasGame = self.game else {
            return nil
        }
        return hasGame.turnOrderManager.turnOrder
    }()

    init(game: Game) {
        self.game = game
    }
}

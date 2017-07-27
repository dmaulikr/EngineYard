//
//  NewTurnOrderViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class NewTurnOrderViewModel: NextStateTransitionProtocol
{
    var game: Game?
    
    init(game: Game) {
        self.game = game
    }

    static var cellReuseIdentifier = "turnOrderCellReuseID"

    lazy var playersSortedByLowestCash : [Player]? = {
        guard let gameObj = self.game else {
            return nil
        }
        return PlayerAPI.sortPlayersByLowestCash(players: gameObj.players)
    }()

    // MARK: - NextStateTransitionProtocol

    internal func shouldTransitionToNextState() -> Bool {
        // true: if all turns complete
        return false
    }

    internal func transitionToNextState() {
        
    }

}

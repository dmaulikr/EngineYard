//
//  NewTurnOrderViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class NewTurnOrderViewModel : BaseViewModel
{
    static var cellReuseIdentifier = "turnOrderCellReuseID"

    lazy var players : [Player]? = {
        guard let gameObj = self.game else {
            return nil
        }
        return gameObj.turnOrderManager.turnOrder
    }()

    lazy var sortPlayersByLowestCash : [Player]? = {
        guard let gameObj = self.game else {
            return nil
        }
        return PlayerAPI.sortPlayersByLowestCash(players: gameObj.players)
    }()
    
}

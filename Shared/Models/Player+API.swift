//
//  Player+API.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class PlayerAPI {

    public static func setSeedCash(players:[Player], amount:Int) -> [Player] {
        _ = players.map({
            $0.account.credit(amount: amount)
        })
        return players
    }

    public static func sortPlayersByHighestCash(players:[Player]) -> [Player] {
        let sortedByHighestCash = players.sorted { (e1:Player, e2:Player) -> Bool in
            return (e1.cash > e2.cash)
        }
        return sortedByHighestCash
    }
    
    
}

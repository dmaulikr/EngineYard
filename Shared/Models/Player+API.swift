//
//  Player+API.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class PlayerAPI {

    public static func setSeedCash(players: [Player], amount: Int) -> [Player] {
        _ = players.map({
            //$0.account.credit(amount: amount)
            $0.wallet.credit(amount: amount)
        })
        return players
    }


    public static func sortPlayersByHighestCash(players: [Player]) -> [Player] {
        let results = players.sorted { (e1:Player, e2:Player) -> Bool in
            return (e1.wallet.balance > e2.wallet.balance)
        }
        return results
    }

    public static func sortPlayersByLowestCash(players: [Player]) -> [Player] {
        let results = players.sorted { (e1:Player, e2:Player) -> Bool in
            return (e1.wallet.balance < e2.wallet.balance)
        }
        return results
    }

    public static func applyTax(players: [Player], callback: @escaping (Bool) -> ()) {
        let _ = players.map({
            let taxDue = Tax.calculateTaxDue(onBalance: $0.wallet.balance)
            $0.wallet.debit(amount: taxDue)
        })
        
        callback(true)
    }
    
}

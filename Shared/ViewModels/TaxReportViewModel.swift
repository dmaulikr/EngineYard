//
//  TaxReportViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 03/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class TaxReportViewModel : BaseViewModel
{
    lazy var gameGoalWasReached: Bool = {
        guard let hasGame = self.game else {
            return false
        }

        let results = PlayerAPI.listOfPlayersWhoReachedGameGoal(players: hasGame.players)
        return (results.count > 0)
    }()

    lazy var nextSegueIdentifier: String = {
        var identifier: String

        if (self.gameGoalWasReached) {
            identifier = "winnerSegue"
        }
        else {
            identifier = "marketDemandsSegue"
        }

        return identifier
    }()

    func applyTaxes(callback: @escaping (Bool) -> ()) {

        guard let hasGame = self.game else {
            callback(false)
            return
        }

        PlayerAPI.applyTax(players: hasGame.players) { (completed) in
            if (completed) {
                callback(true)
            }
        }
    }
}

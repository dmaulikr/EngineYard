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

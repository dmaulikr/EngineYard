//
//  TrainDetailViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 27/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

struct TrainDetailViewModel
{
    var game: Game?
    weak var locomotive: Locomotive?

    init(game: Game, locomotive: Locomotive) {
        self.game = game
        self.locomotive = locomotive
    }

    lazy var buyButtonText: String? = {
        guard let loco = self.locomotive else {
            return "N/A"
        }
        let costNumber = NSNumber(integerLiteral: loco.cost)
        let costText: String = ObjectCache.currencyRateFormatter.string(from: costNumber)!
        return "Buy \(loco.name) for \(costText)"
    }()


    func purchaseTrain(train: Locomotive, player: Player) {
        if (player.account.canAfford(amount: train.cost) == false)
        {
            print ("You cannot afford this locomotive! Cash: \(player.cash) vs Loco: \(train.cost)")
            return
        }
        else {

        }

    }
}

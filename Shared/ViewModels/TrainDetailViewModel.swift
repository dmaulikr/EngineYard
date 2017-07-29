//
//  TrainDetailViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 27/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class TrainDetailViewModel
{
    weak var game: Game?
    weak var locomotive: Locomotive?

    init(game: Game, locomotive: Locomotive) {
        self.game = game
        self.locomotive = locomotive

        guard let hasGame = self.game else {
            assertionFailure("** No game model defined **")
            return
        }

        guard let _ = hasGame.gameBoard else {
            assertionFailure("** No game board defined **")
            return
        }
    }

    lazy var buyButtonText: String? = {
        guard let loco = self.locomotive else {
            return "N/A"
        }
        let costNumber = NSNumber(integerLiteral: loco.cost)
        let costText: String = ObjectCache.currencyRateFormatter.string(from: costNumber)!
        return "Buy \(loco.name) for \(costText)"
    }()

    func canPurchaseTrain(train: Locomotive, player: Player) -> Bool {
        return (player.account.canAfford(amount: train.cost))
    }

    func purchaseTrain(train: Locomotive, player: Player) {
        if (self.canPurchaseTrain(train: train, player: player)) {
            train.purchase(buyer: player)
        }
    }
}

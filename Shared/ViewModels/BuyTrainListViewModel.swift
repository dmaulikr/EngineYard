//
//  BuyTrainListViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 01/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class BuyTrainListViewModel : BaseViewModel
{
    lazy var trains: [Train]? = {
        guard let hasGame = self.game else {
            return nil
        }
        guard let hasBoard = hasGame.gameBoard else {
            return nil
        }
        let filtered = hasBoard.decks.sorted(by: { (t1: Train, t2: Train) -> Bool in
            return (t1.cost < t2.cost)
        })
        return filtered
    }()
}

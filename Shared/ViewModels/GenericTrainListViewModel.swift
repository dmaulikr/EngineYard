//
//  GenericTrainListViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class GenericTrainListViewModel : BaseViewModel
{
    var trains: [Train]?
    var pageTitle: String?

    var hudDisableCellSelection = false
    var shouldSelectItemAt = true

    init(game: Game, trains: [Train]) {
        super.init(game: game)
        self.trains = trains
    }
}

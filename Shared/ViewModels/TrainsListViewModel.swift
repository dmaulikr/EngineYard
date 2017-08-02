//
//  TrainsListViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class TrainsListViewModel : BaseViewModel
{
    var trains: [Train]?

    init(game: Game, trains: [Train]) {
        super.init(game: game)
        self.trains = trains
    }
}

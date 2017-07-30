//
//  Train+API.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class TrainAPI {

    public static func buildAll() -> [Train]
    {
        let startingPrice: Int = 4
        let trains: [Train] = [
            Train.init(name: "Green.1", generation: .first, engineColor: .green, capacity: 3, numberOfChildren: 4)
            , Train.init(name: "Red.1", generation: .first, engineColor: .red, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Yellow.1", generation: .first, engineColor: .yellow, capacity: 2, numberOfChildren: 2)
            , Train.init(name: "Blue.1", generation: .first, engineColor: .blue, capacity: 1, numberOfChildren: 1)
            , Train.init(name: "Green.2", generation: .second, engineColor: .green, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Red.2", generation: .second, engineColor: .red, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Yellow.2", generation: .second, engineColor: .yellow, capacity: 3, numberOfChildren: 2)
            , Train.init(name: "Green.3", generation: .third, engineColor: .green, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Blue.2", generation: .second, engineColor: .blue, capacity: 2, numberOfChildren: 2)
            , Train.init(name: "Red.3", generation: .third, engineColor: .red, capacity: 4, numberOfChildren: 3)
            , Train.init(name: "Green.4", generation: .fourth, engineColor: .green, capacity: 5, numberOfChildren: 4)
            , Train.init(name: "Yellow.3", generation: .third, engineColor: .yellow, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Red.4", generation: .fourth, engineColor: .red, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Green.5", generation: .fifth, engineColor: .green, capacity: 5, numberOfChildren: 4)
        ]

        for (index, t) in trains.enumerated() {
            t.cost = (index * startingPrice)
        }

        return trains
    }
}

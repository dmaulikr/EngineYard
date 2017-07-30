//
//  Train.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class Train : NSObject {
    var name: String!
    var cost: Int!
    var productionCost: Int!
    var income: Int!
    var generation: Generation = .first
    var engineColor: EngineColor = .green

    init(name: String, generation: Generation, engineColor: EngineColor) {
        super.init()
        self.name = name
        self.generation = generation
        self.engineColor = engineColor
    }

}

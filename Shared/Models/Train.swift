//
//  Train.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Train : NSObject
{
    public private (set) var uuid: String = UUID().uuidString
    var name: String!
    var cost: Int!
    var productionCost: Int!
    var income: Int!
    var generation: Generation = .first
    var engineColor: EngineColor = .green
    var capacity: Int = 0
    var numberOfChildren: Int = 0

    // # Obsolescence variables
    public fileprivate(set) var isRusting : Bool = false {
        didSet {
            print ("\(self.name) is rusting")
        }
    }
    public fileprivate(set) var hasRusted: Bool = false {
        didSet {
            print ("\(self.name) has rusted - OBSOLETE")
        }
    }

    init(name:String, generation:Generation, engineColor:EngineColor, capacity:Int, numberOfChildren:Int) {
        super.init()
        self.name = name
        self.generation = generation
        self.engineColor = engineColor
        self.capacity = capacity
        self.numberOfChildren = numberOfChildren
    }

}

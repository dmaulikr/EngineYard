//
//  Production+API.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class ProductionAPI : NSObject {

    static func unitsCanAfford(cash:Int, productionCost:Int) -> Int {
        return Int(floor( (Float(cash)) / (Float(productionCost)) ))
    }

}

//
//  Train.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation


protocol TrainProtocol {
    var name: String { get }
    var cost: Int { get }
    var productionCost: Int { get }
    var income: Int { get }
    var generation: Generation { get }
    var engineColor: EngineColor { get }

    var isUnlocked: Bool { get }
    var capacity: Int { get } // capacity of orders, sales array
    var numberOfChildren: Int { get } // how many cards (engines) to create

    var isRusting: Bool { get } // Obsolescence
    var hasRusted: Bool { get } // Obsolescence
}



class Train : NSObject {

    

}

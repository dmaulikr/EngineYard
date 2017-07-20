//
//  StateManager.swift
//  EngineYard
//
//  Created by Amarjit on 18/05/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

class StateManager: NSObject {

    static var instance = StateManager()

    let gameStates : GKStateMachine = GKStateMachine.init(states: [
        BuyLocomotiveState(),
        BuyProductionState(),
        SellingRoundState(),
        PayTaxesState(),
        MarketDemandsState(),
        WinnerDeclaredState()
    ])
}

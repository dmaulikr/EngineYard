//
//  GameStates.swift
//  EngineYard
//
//  Created by Amarjit on 18/05/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

// # Important -- Uses iOS9.x Gameplaykit #
// Menu states: [ MainMenuState -> NewGameSetupState -> BuyLocomotiveState ]
// Game states: [ BuyLocomotive -> BuyProduction -> SellingRounds -> PayTaxes -> (MarketDemands || WinnerDeclared)
// Other states: (PlayGameState -> PauseState)

class NewGameSetupState : GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is BuyLocomotiveState.Type)
    }

    override func didEnter(from previousState: GKState?) {
        print ("Entered NewGameSetupState")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited NewGameSetupState")
    }
}

// A player can either buy or skip a single locomotive purchase
class BuyLocomotiveState : GKState
{
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is BuyProductionState.Type)
    }

    override func didEnter(from previousState: GKState?) {
        print ("Entered BuyLocomotiveState")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited BuyLocomotiveState")
    }
}

// A player can either buy or skip production
class BuyProductionState : GKState
{
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is SellingRoundState.Type)
    }

    override func didEnter(from previousState: GKState?) {
        print ("Entered BuyProductionState")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited BuyProductionState")
    }
}

// Selling rounds are automatically handled by computer
class SellingRoundState : GKState
{
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is PayTaxesState.Type)
    }

    override func didEnter(from previousState: GKState?) {
        print ("Entered SellingRoundState")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited SellingRoundState")
    }
}

// Tax rounds are automatically handled by computer
class PayTaxesState : GKState
{
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (
            (stateClass is MarketDemandsState.Type) ||
            (stateClass is WinnerDeclaredState.Type)
        )
    }

    override func didEnter(from previousState: GKState?) {
        print ("Entered PayTaxesState")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited PayTaxesState")
    }
}

// Market demands are automatically handled by computer
class MarketDemandsState : GKState
{
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return (stateClass is BuyLocomotiveState.Type)
    }

    override func didEnter(from previousState: GKState?) {
        print ("Entered MarketDemandsState")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited MarketDemandsState")
    }
}

// Has no exits
class WinnerDeclaredState : GKState
{
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return false
    }

    override func didEnter(from previousState: GKState?) {
        print ("Entered WinnerDeclaredState")
    }

    override func willExit(to nextState: GKState) {
        print ("Exited WinnerDeclaredState")
    }
}

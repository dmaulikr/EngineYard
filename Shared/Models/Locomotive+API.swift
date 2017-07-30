//
//  Locomotive+API.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import ObjectMapper

class LocomotiveCardAPI : NSObject {



    public static func allLocomotives(gameBoard: GameBoard) -> [Locomotive] {
        return (gameBoard.decks.sorted(by: { (loco1:Locomotive, loco2:Locomotive) -> Bool in
            return (loco1.cost < loco2.cost)
        }))
    }

    public static func getSalesTurnOrderForTrain(train:Locomotive) -> [Engine] {
        let engines = train.engines.filter({ (eng:Engine) -> Bool in
            return ( ((eng.owner != nil) && (eng.parent?.existingOrders.count)! > 0) && (eng.production.units > 0) )
        }).sorted(by: { (eng1:Engine, eng2:Engine) -> Bool in
            return ((eng1.owner?.turnOrder)! < (eng2.owner?.turnOrder)!)
        })
        return engines
    }


    public static func canPurchase(train:Locomotive, player: Player) -> (Bool, Error?) {
        if (!train.isUnlocked) {
            print ("not unlocked")
            return (false, ErrorCode.notUnlocked)
        }

        if (!(player.account.canAfford(amount: train.cost))) {
            print ("insufficent funds")
            return (false, ErrorCode.insufficientFunds(coinsNeeded: train.cost))
        }

        // Does player already own the locomotive?
        let ownedEngines = player.engines.filter { (eng:Engine) -> Bool in
            return ((eng.owner == player) && (eng.parent == train))
        }

        if (ownedEngines.count > 0) {
            print ("already own train")
            return (false, ErrorCode.alreadyOwnTrain)
        }

        return (true, nil)
    }
    
    
    public static func findLocomotiveInDeck(decks:[Locomotive], whereColor:EngineColor, whereGeneration:Generation) -> Locomotive? {
        guard let firstLoco = (decks.filter({ (loco:Locomotive) -> Bool in
            return (loco.engineColor == whereColor) && (loco.generation == whereGeneration)
        }).first) else {
            return nil
        }
        return firstLoco
    }



}

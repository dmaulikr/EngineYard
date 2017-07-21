//
//  Locomotive+API.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import ObjectMapper

class LocomotiveAPI : NSObject {

    public static func loadFixtures() -> [Locomotive]
    {
        let trains: [Locomotive] = [
            Locomotive.init(name: "Green.1", cost: 4, generation: .first, engineColor: .green, capacity: 3, numberOfChildren: 4)
            , Locomotive.init(name: "Red.1", cost: 8, generation: .first, engineColor: .red, capacity: 3, numberOfChildren: 3)
            , Locomotive.init(name: "Yellow.1", cost: 12, generation: .first, engineColor: .yellow, capacity: 2, numberOfChildren: 2)
            , Locomotive.init(name: "Blue.1", cost: 16, generation: .first, engineColor: .blue, capacity: 1, numberOfChildren: 1)
            , Locomotive.init(name: "Green.2", cost: 20, generation: .second, engineColor: .green, capacity: 4, numberOfChildren: 4)
            , Locomotive.init(name: "Red.2", cost: 24, generation: .second, engineColor: .red, capacity: 3, numberOfChildren: 3)
            , Locomotive.init(name: "Yellow.2", cost: 28, generation: .second, engineColor: .yellow, capacity: 3, numberOfChildren: 2)
            , Locomotive.init(name: "Green.3", cost: 32, generation: .third, engineColor: .green, capacity: 4, numberOfChildren: 4)
            , Locomotive.init(name: "Blue.2", cost: 36, generation: .second, engineColor: .blue, capacity: 2, numberOfChildren: 2)
            , Locomotive.init(name: "Red.3", cost: 40, generation: .third, engineColor: .red, capacity: 4, numberOfChildren: 3)
            , Locomotive.init(name: "Green.4", cost: 44, generation: .fourth, engineColor: .green, capacity: 5, numberOfChildren: 4)
            , Locomotive.init(name: "Yellow.3", cost: 48, generation: .third, engineColor: .yellow, capacity: 3, numberOfChildren: 3)
            , Locomotive.init(name: "Red.4", cost: 52, generation: .fourth, engineColor: .red, capacity: 4, numberOfChildren: 4)
            , Locomotive.init(name: "Green.5", cost: 56, generation: .fifth, engineColor: .green, capacity: 5, numberOfChildren: 4)
        ]

        return trains
    }

    public static func getSalesTurnOrderForTrain(train:Locomotive) -> [Engine] {
        let engines = train.engines.filter({ (eng:Engine) -> Bool in
            return ( ((eng.owner != nil) && (eng.parent?.existingOrders.count)! > 0) && (eng.production.units > 0) )
        }).sorted(by: { (eng1:Engine, eng2:Engine) -> Bool in
            return ((eng1.owner?.turnOrder)! < (eng2.owner?.turnOrder)!)
        })
        return engines
    }

    public static func purchase(train:Locomotive, player:Player) {
        if (LocomotiveAPI.canPurchase(train: train, player: player).0) {

            let remainingEngines = train.engines.filter({ (eng: Engine) -> Bool in
                return (eng.owner == nil) && (eng.parent == train)
            })

            print ("There are \(remainingEngines.count) remaining unowned engines in \(train.name)")

            guard let firstUnownedEngine = remainingEngines.first else {
                print("No engine found")
                assertionFailure()
                return
            }

            player.account.debit(amount: train.cost)
            firstUnownedEngine.assignOwner(player: player)

            // only unlock the next one if possible
            if ( (remainingEngines.count == train.numberOfChildren) && (remainingEngines.count == train.engines.count) ) {

                // Post notification
                NotificationCenter.default.post(name: .boughtTrainNotificationId, object: nil)
            }
        }
    }

    private static func canPurchase(train:Locomotive, player: Player) -> (Bool, Error?) {
        if (!train.isUnlocked) {
            return (false, ErrorCode.notUnlocked)
        }

        if (!(player.account.canAfford(amount: train.cost))) {
            return (false, ErrorCode.insufficientFunds(coinsNeeded: train.cost))
        }

        // Does player already own the locomotive?
        let ownedEngines = player.engines.filter { (eng:Engine) -> Bool in
            return ((eng.owner == player) && (eng.parent == train))
        }

        if (ownedEngines.count > 0) {
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

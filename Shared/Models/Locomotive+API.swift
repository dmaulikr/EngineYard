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

    //    public static func fetchLocomotivesBelongingTo(player:Player) -> [Locomotive] {
    //        var trains: [Locomotive] = [Locomotive]()
    //        let results = player.engines.filter { (eng:Engine) -> Bool in
    //            return ((eng.parent != nil))
    //        }
    //        return trains
    //    }

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


    // MARK: - Fetch and Parse

    // fetch the parsed locomotives from `data.json` file
    public static func fetchLocomotives() -> [Locomotive] {
        var locos:[Locomotive] = [Locomotive]()

        LocomotiveAPI.parseLocomotivesFromLocalJSONFile { (success, error, objects) in
            if (error != nil) {
                print (error?.localizedDescription as Any)
            }
            if (success) {
                guard let hasObjects = objects else {
                    return
                }
                locos = hasObjects
            }
        }

        return locos
    }

    // MARK: - (Private) methods

    fileprivate static func parseLocomotivesFromLocalJSONFile(taskCallback: @escaping (Bool, Error?, [Locomotive]?) -> ()) {

        DataManager.getJSON { (success, error, json) in
            if (error != nil) {
                taskCallback(false, error, nil)
            }
            guard let jsonObject = json else {
                let err = NSError(domain: "No data found", code: 0, userInfo: nil)
                taskCallback(false, err, nil)
                return
            }
            if ((success) && (json != nil)) {
                let objects = Mapper<Locomotive>().mapArray(JSONArray: jsonObject)!

                if (objects.count == 0) {
                    let err = NSError(domain: "No data found", code: 0, userInfo: nil)
                    taskCallback(false, err, nil)
                }
                else {
                    taskCallback(true, nil, objects)
                }
                
                return
            }
        }
    }
    
}

//
//  Train+API.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class TrainAPI
{
    // find first card in train.cards with nil owner (if possible)
    public static func findFirstUnownedCard(for train: Train) -> LocomotiveCard?
    {
        guard let card = (train.cards.filter({ (card) -> Bool in
            return (card.owner == nil)
        }).first) else {
            return nil
        }

        return card
    }

    // #TODO - Make it so that only protocols can fire this
    public static func unlockNextDeck() {
        NotificationCenter.default.post(name: .boughtTrainNotificationId, object: nil)
    }

    public static func findTrainInDeck(decks: [Train], whereColor: EngineColor, whereGeneration: Generation) -> Train? {
        guard let firstTrain = (decks.filter({ (train: Train) -> Bool in
            return (train.engineColor == whereColor) && (train.generation == whereGeneration)
        }).first) else {
            return nil
        }
        return firstTrain
    }

    public static func getRemainingStock(train: Train) -> Int {
        if (train.numberOfChildren > 0) {
            guard let owners = train.owners?.count else {
                return train.numberOfChildren
            }
            return (train.numberOfChildren - owners)
        }
        return train.numberOfChildren
    }

    public static func isValidPurchase(train: Train, player: Player) -> (Bool, Error?) {
        do {
            let result = try train.canBePurchased(by: player)
            return (result, nil)
        } catch let error {
            return (false, error)
        }
    }

}

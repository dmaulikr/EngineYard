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
    public static func findTrainInDeck(decks: [Train], whereColor: EngineColor, whereGeneration: Generation) -> Train? {
        guard let firstTrain = (decks.filter({ (train: Train) -> Bool in
            return (train.engineColor == whereColor) && (train.generation == whereGeneration)
        }).first) else {
            return nil
        }
        return firstTrain
    }

    public static func canPurchase(train: Train, buyer: Player) -> Bool {
        return false
    }
}

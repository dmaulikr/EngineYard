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
    public static func getNextLockedDeck(in gameBoard: GameBoard) -> Train?
    {
        let results = gameBoard.decks.filter { (train: Train) -> Bool in
            return (train.isUnlocked == false)
        }

        return results.first
    }

    public static func countUnlockedDecks(in gameBoard: GameBoard) -> Int {
        let results = gameBoard.decks.reduce(0) { $0 + ($1.isUnlocked ? 1 : 0) }
        return results
    }

    public static func findTrainInDeck(decks: [Train], whereColor: EngineColor, whereGeneration: Generation) -> Train? {
        guard let firstTrain = (decks.filter({ (train: Train) -> Bool in
            return (train.engineColor == whereColor) && (train.generation == whereGeneration)
        }).first) else {
            return nil
        }
        return firstTrain
    }
}

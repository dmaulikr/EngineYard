//
//  LocomotiveCardAPI.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class LocomotiveCardAPI {

    //self.cards = LocomotiveCardAPI.createCardsForTrain(train: self)
    static func createCardsForTrain(train: Train) -> [LocomotiveCard]? {
        guard train.cards.count == 0 else {
            return nil
        }

        var cards: [LocomotiveCard] = [LocomotiveCard]()

        for _ in stride(from:0, to: train.numberOfChildren, by: 1) {
            let card : LocomotiveCard = LocomotiveCard.init(parent: train)
            //train.cards.append(card)
            cards.append(card)
        }

        return cards
    }

}

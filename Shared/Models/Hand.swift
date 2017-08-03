//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// Each player has their own hand of cards
class Hand : CustomStringConvertible
{
    public fileprivate(set) weak var owner: Player?
    public fileprivate(set) var cards: [LocomotiveCard] = [LocomotiveCard]()

    init(owner: Player) {
        self.owner = owner
    }

    func containsTrain(train: Train) -> Bool {

        // does my hand already contain the train
        let filter1 = self.cards.contains(where: {
            return ($0.parent == train)
        })

        if (filter1 == true) {
            return true
        }
        else {
            // is there any nil owner spaces available

            let results = train.cards.filter({ (card) -> Bool in
                return (card.owner == nil)
            })

            print (results.count)

            return (results.count == 0)
        }
    }

    func add(train: Train) {
        guard let hasOwner = self.owner else {
            assertionFailure("Hand has no owner")
            return
        }
        guard let card = self.canAdd(train: train) else {
            return
        }
        card.setOwner(owner: hasOwner)
        self.cards.append(card)
        card.productionDelegate?.setDefaultProduction()
    }

    func canAdd(train: Train) -> LocomotiveCard? {
        if (self.containsTrain(train: train) == false) {

            guard let card = TrainAPI.findFirstUnownedCard(for: train) else {
                return nil
            }

            return card
        }

        return nil
    }


}

extension Hand {
    var description: String {
        return ("Hand: \(self.cards.count)")
    }
}

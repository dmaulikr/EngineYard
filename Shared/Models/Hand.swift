//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// Each player has their own hand of cards

class Hand: CustomStringConvertible
{
    public fileprivate(set) weak var owner: Player?
    public fileprivate(set) var cards: [LocomotiveCard] = [LocomotiveCard]()

    init(owner: Player) {
        self.owner = owner
    }

    func add(card: LocomotiveCard) {
        guard let hasOwner = self.owner else {
            assertionFailure("This hand is not assigned to any player")
            return
        }
        if (canAdd(card: card)) {
            card.setOwner(owner: hasOwner)
            card.production.setDefaultProduction()
            cards.append(card)
        }
    }

    func canAdd(card: LocomotiveCard) -> Bool {
        guard let hasOwner = self.owner else {
            assertionFailure("This hand is not assigned to any player")
            return false
        }

        guard let hasDeckParent = card.parent else {
            assertionFailure("This card is not assigned to any deck")
            return false
        }

        if (hasDeckParent.isOwned(by: hasOwner)) {
            return false
        }

        return true
        /**
        let results = self.cards.filter { (cardObj: LocomotiveCard) -> Bool in
            return (
                (cardObj.owner === self.owner) &&
                    ((cardObj.parent?.engineColor == card.parent?.engineColor) &&
                        (cardObj.parent?.generation == card.parent?.generation))
            )
        }
        print (results.count)
        return (results.count == 0)
         **/
    }
}

extension Hand {
    var description: String {
        return ("Hand: \(self.cards.count)")
    }
}

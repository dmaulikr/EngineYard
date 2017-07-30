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
        // make sure the card is not owned by anybody
        guard card.owner == nil else {
            return false
        }

        // find first loco that matches the card and matches right color, etc

        let whereEngineColor = card.parent?.engineColor
        let whereGeneration = card.parent?.generation

        // search my hand for type, can't own more than 1 of each type
        let filterMyHand = self.cards.filter { (lc: LocomotiveCard) -> Bool in
            return ((lc.parent?.engineColor == whereEngineColor) &&
                (lc.parent?.generation == whereGeneration))
        }

        return (filterMyHand.count == 0) 
    }
}

extension Hand {
    var description: String {
        return ("Hand: \(self.cards.count)")
    }
}

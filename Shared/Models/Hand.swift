//
//  Hand.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

protocol HandDelegate: class {
    func didAdd(card: LocomotiveCard)
}

// Each player has their own hand of cards
class Hand : CustomStringConvertible
{
    weak var delegate: HandDelegate?

    public fileprivate(set) weak var owner: Player?
    public fileprivate(set) var cards: [LocomotiveCard] = [LocomotiveCard]()

    init(owner: Player) {
        self.owner = owner
    }

    func containsTrain(train: Train) -> Bool {

        // does my hand already contain the train
        let filter = self.cards.contains(where: {
            return ($0.parent == train)
        })

        if (filter) {
            return filter
        }
        else {
            // is there any nil owner spaces available

            let results = train.cards.filter({ (card) -> Bool in
                return ((card.owner == self.owner) || (card.owner == nil))
            })

            return results.count == 0
        }
    }


    
    func add(card: LocomotiveCard) {
        guard let hasOwner = self.owner else {
            assertionFailure("This hand is not assigned to any player")
            return
        }
        self.delegate = card.production

        if (canAdd(card: card)) {
            card.setOwner(owner: hasOwner)
            self.delegate?.didAdd(card: card)
            cards.append(card)
        }
    }

    internal func canAdd(card: LocomotiveCard) -> Bool {
        // I expect that card has no owner
        guard card.owner == nil else {
            return false
        }

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

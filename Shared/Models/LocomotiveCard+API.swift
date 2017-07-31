//
//  LocomotiveCardAPI.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class LocomotiveCardAPI {

    public static func canPurchase(card: LocomotiveCard, buyer: Player) -> Bool {
        guard let parent = card.parent else {
            return false
        }
        if (!parent.isUnlocked) {
            return false
        }
        if (!buyer.wallet.canAfford(amount: parent.cost)) {
            return false
        }
        if (!buyer.hand.canAdd(card: card)) {
            return false
        }
        return true
    }

    public static func findFirstUnownedCard(for train:Train) -> LocomotiveCard? {

        guard let firstUnownedCard = train.cards.filter({ (card: LocomotiveCard) -> Bool in
            return (card.owner == nil)
        }).first else {
            return nil
        }

        return firstUnownedCard
    }


}

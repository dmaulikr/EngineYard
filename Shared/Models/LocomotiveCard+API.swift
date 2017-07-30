//
//  LocomotiveCardAPI.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class LocomotiveCardAPI {

    public static func findFirstUnownedCard(for train:Train) -> LocomotiveCard? {

        guard let firstUnownedCard = train.cards.filter({ (card: LocomotiveCard) -> Bool in
            return (card.owner == nil)
        }).first else {
            return nil
        }

        return firstUnownedCard
    }


}

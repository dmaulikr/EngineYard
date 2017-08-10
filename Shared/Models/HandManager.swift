//
//  HandManager.swift
//  EngineYard
//
//  Created by Amarjit on 10/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class HandManager
{
    weak var train: Train?
    weak var player: Player?

    init(train: Train, player: Player) {
        self.train = train
        self.player = player
    }

    func canAdd(train: Train, toPlayersHand: Hand) -> Bool {
        return false
    }

    func add(train: Train, toPlayersHand: Hand) {
        
    }



    /*
     func add(train: Train) -> Bool {
     guard let hasOwner = self.owner else {
     assertionFailure("Hand has no owner")
     return false
     }
     guard let card = self.canAdd(train: train) else {
     return false
     }
     card.setOwner(owner: hasOwner)
     self.cards.append(card)
     card.productionDelegate?.setDefaultProduction()

     return true
     }

     internal func canAdd(train: Train) -> LocomotiveCard? {
     if (self.containsTrain(train: train) == false) {

     guard let card = TrainAPI.findFirstUnownedCard(for: train) else {
     return nil
     }

     return card
     }

     return nil
     }*/
}

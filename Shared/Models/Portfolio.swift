//
//  Portfolio.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Portfolio : NSObject
{
    weak var owner: Player?
    var cards: [LocomotiveCard] = [LocomotiveCard]()

    init(owner: Player) {
        super.init()
        self.owner = owner
    }

    


    /*
    func add(card: LocomotiveCard) {
        if (canAdd(card: card)) {
            card.owner = self.owner
            card.production.setDefaultProduction()
            self.cards.append(card)
        }
        else {
            print("Cannot add \(card.description) to portfolio, already own it")
        }
    }

    func canAdd(card: LocomotiveCard) -> Bool {
        let results = self.cards.filter { (cardObj: LocomotiveCard) -> Bool in
            return (cardObj.parent?.uuid == card.parent?.uuid)
        }.count

        return (results > 0)
    }
    */
}

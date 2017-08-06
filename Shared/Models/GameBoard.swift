//
//  GameBoard.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

protocol GameBoardProtocol {
    func unlockNextDeck( _ deck: Deck )
}

final class GameBoard : GameBoardProtocol
{
    fileprivate var _decks: [Deck] = [Deck]()

    var countUnlocked : Int {
        return (self.decks.reduce(0) { $0 + ($1.isUnlocked ? 1 : 0) })
    }

    public var decks: [Deck] {
        return self._decks.sorted(by: { (t1: Deck, t2: Deck) -> Bool in
            return (t1.cost < t2.cost)
        })
    }

    init() {
        if (self.decks.count == 0) {
            self.prepare()
        }
    }
}

extension GameBoard {

    internal func unlockNextDeck(_ deck: Deck) {
        guard let nextDeck = self.decks.after(deck) else {
            return
        }

        guard (!nextDeck.isUnlocked) else {
            return
        }

        nextDeck.didUnlock()
    }
}

extension GameBoard {

    // MARK: - Prepare board

    fileprivate func prepare() {

        let trains = [
            Train.init(name: "Green.1", cost: 4, generation: .first, engineColor: .green, capacity: 3, numberOfChildren: 4)
            , Train.init(name: "Red.1", cost: 8, generation: .first, engineColor: .red, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Yellow.1", cost: 12, generation: .first, engineColor: .yellow, capacity: 2, numberOfChildren: 2)
            , Train.init(name: "Blue.1", cost: 16, generation: .first, engineColor: .blue, capacity: 1, numberOfChildren: 1)
            , Train.init(name: "Green.2", cost: 20, generation: .second, engineColor: .green, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Red.2", cost: 24, generation: .second, engineColor: .red, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Yellow.2", cost: 28, generation: .second, engineColor: .yellow, capacity: 3, numberOfChildren: 2)
            , Train.init(name: "Green.3", cost: 32, generation: .third, engineColor: .green, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Blue.2", cost: 36, generation: .second, engineColor: .blue, capacity: 2, numberOfChildren: 2)
            , Train.init(name: "Red.3", cost: 40, generation: .third, engineColor: .red, capacity: 4, numberOfChildren: 3)
            , Train.init(name: "Green.4", cost: 44, generation: .fourth, engineColor: .green, capacity: 5, numberOfChildren: 4)
            , Train.init(name: "Yellow.3", cost: 48, generation: .third, engineColor: .yellow, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Red.4", cost: 52, generation: .fourth, engineColor: .red, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Green.5", cost: 56, generation: .fifth, engineColor: .green, capacity: 5, numberOfChildren: 4)
        ]

        // add subscriber
        let _ = trains.map({
            $0.addSubscriber(self)
        })

        self._decks = trains
    }


}

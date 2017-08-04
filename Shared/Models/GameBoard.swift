//
//  GameBoard.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let boughtTrainNotificationId = Notification.Name("boughtTrainNotificationId")
}

protocol DeckProtocol {
    var decks: [Train] { get }
    func unlockNextDeck()
}

final class GameBoard: DeckProtocol
{
    fileprivate var _decks: [Train] = [Train]()

    public var decks: [Train] {
        return self._decks.sorted(by: { (t1: Train, t2: Train) -> Bool in
            return (t1.cost < t2.cost)
        })
    }

    var countUnlocked : Int {
        return (self.decks.reduce(0) { $0 + ($1.isUnlocked ? 1 : 0) })
    }

    // MARK: - Register Notifications

    init() {
        registerForNotifications()
    }

    deinit {
        removeNotifications()
    }

    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPurchaseTrain), name: .boughtTrainNotificationId, object: nil)
    }

    func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: .boughtTrainNotificationId, object: nil)
    }

    @objc func didPurchaseTrain() {
        print ("didPurchaseTrain")
        self.unlockNextDeck()
    }


    func reset() {
        self._decks.removeAll()
    }
}

extension GameBoard {

    // MARK: - GameBoard delegate method

    internal func unlockNextDeck() {
        print (self.decks.description)
        assert(self.decks.count > 0, "invalid decks: \(self.decks.count)")

        guard let train = (self.decks.filter({
            return ($0.isUnlocked == false)
        }).first) else {
            return
        }

        self.didUnlockNextDeck(train: train)
    }

    private func didUnlockNextDeck(train: Train) {
        let order = ExistingOrder.generate()
        train.orderBook.add(order: order)
        print ("Unlocked: \(train.name) -- Added new order: \(order.description) => \(train.orderBook.existingOrders)")
    }

    /**
    internal func nextDeckToUnlock() -> Train? {

        print (self.decks.description)

        guard let firstLockedDeck = (self.decks.filter({
            return ($0.isUnlocked == false)
        }).first) else {
            return nil
        }

        print ("Unlocking: \(firstLockedDeck.name)")

        return firstLockedDeck
    }

    internal func unlockNextDeck() {
        guard let train = nextDeckToUnlock() else {
            return
        }

        self.didUnlockNextDeck(train: train)
    }

        **/

}

extension GameBoard {

    // MARK: - Prepare board

    public static func prepare() -> GameBoard {
        let gameBoard = GameBoard()

        // # prepare decks
        gameBoard._decks = self.prepareDecks()

        // # save to db (#TODO)

        return gameBoard
    }

    fileprivate static func prepareDecks() -> [Train] {
        let trains: [Train] = [
              Train.init(name: "Green.1", cost: 4, generation: .first, engineColor: .green, capacity: 3, numberOfChildren: 4, delegate:  GameBoard())
            , Train.init(name: "Red.1", cost: 8, generation: .first, engineColor: .red, capacity: 3, numberOfChildren: 3, delegate:  GameBoard())
            , Train.init(name: "Yellow.1", cost: 12, generation: .first, engineColor: .yellow, capacity: 2, numberOfChildren: 2, delegate:  GameBoard())
            , Train.init(name: "Blue.1", cost: 16, generation: .first, engineColor: .blue, capacity: 1, numberOfChildren: 1, delegate:  GameBoard())
            , Train.init(name: "Green.2", cost: 20, generation: .second, engineColor: .green, capacity: 4, numberOfChildren: 4, delegate:  GameBoard())
            , Train.init(name: "Red.2", cost: 24, generation: .second, engineColor: .red, capacity: 3, numberOfChildren: 3, delegate:  GameBoard())
            , Train.init(name: "Yellow.2", cost: 28, generation: .second, engineColor: .yellow, capacity: 3, numberOfChildren: 2, delegate:  GameBoard())
            , Train.init(name: "Green.3", cost: 32, generation: .third, engineColor: .green, capacity: 4, numberOfChildren: 4, delegate:  GameBoard())
            , Train.init(name: "Blue.2", cost: 36, generation: .second, engineColor: .blue, capacity: 2, numberOfChildren: 2, delegate:  GameBoard())
            , Train.init(name: "Red.3", cost: 40, generation: .third, engineColor: .red, capacity: 4, numberOfChildren: 3, delegate:  GameBoard())
            , Train.init(name: "Green.4", cost: 44, generation: .fourth, engineColor: .green, capacity: 5, numberOfChildren: 4, delegate:  GameBoard())
            , Train.init(name: "Yellow.3", cost: 48, generation: .third, engineColor: .yellow, capacity: 3, numberOfChildren: 3, delegate:  GameBoard())
            , Train.init(name: "Red.4", cost: 52, generation: .fourth, engineColor: .red, capacity: 4, numberOfChildren: 4, delegate:  GameBoard())
            , Train.init(name: "Green.5", cost: 56, generation: .fifth, engineColor: .green, capacity: 5, numberOfChildren: 4, delegate:  GameBoard())
        ]        
        return trains
    }

}

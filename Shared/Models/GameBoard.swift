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


final class GameBoard {

    fileprivate var _decks: [Train] = [Train]()

    public var decks: [Train] {
        return self._decks.sorted(by: { (t1: Train, t2: Train) -> Bool in
            return (t1.cost < t2.cost)
        })
    }

    init() {
        registerForNotifications()
    }

    deinit {
        removeNotifications()
    }

    // MARK: - Register Notifications

    func registerForNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.didPurchaseTrain), name: .boughtTrainNotificationId, object: nil)
    }

    func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: .boughtTrainNotificationId, object: nil)
    }

    @objc func didPurchaseTrain() {
        print ("didPurchaseTrain")
    }
}

extension GameBoard {

    // MARK: - Prepare board

    // #TODO - Add callback
    public static func prepare() -> GameBoard {
        let gameBoard = GameBoard()

        // # prepare decks
        gameBoard._decks = self.prepareDecks()

        // # save to db (#TODO)

        return gameBoard
    }

    fileprivate static func prepareDecks() -> [Train] {
        let trains: [Train] = [
            Train.init(name: "Green.1", generation: .first, engineColor: .green, capacity: 3, numberOfChildren: 4)
            , Train.init(name: "Red.1", generation: .first, engineColor: .red, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Yellow.1", generation: .first, engineColor: .yellow, capacity: 2, numberOfChildren: 2)
            , Train.init(name: "Blue.1", generation: .first, engineColor: .blue, capacity: 1, numberOfChildren: 1)
            , Train.init(name: "Green.2", generation: .second, engineColor: .green, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Red.2", generation: .second, engineColor: .red, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Yellow.2", generation: .second, engineColor: .yellow, capacity: 3, numberOfChildren: 2)
            , Train.init(name: "Green.3", generation: .third, engineColor: .green, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Blue.2", generation: .second, engineColor: .blue, capacity: 2, numberOfChildren: 2)
            , Train.init(name: "Red.3", generation: .third, engineColor: .red, capacity: 4, numberOfChildren: 3)
            , Train.init(name: "Green.4", generation: .fourth, engineColor: .green, capacity: 5, numberOfChildren: 4)
            , Train.init(name: "Yellow.3", generation: .third, engineColor: .yellow, capacity: 3, numberOfChildren: 3)
            , Train.init(name: "Red.4", generation: .fourth, engineColor: .red, capacity: 4, numberOfChildren: 4)
            , Train.init(name: "Green.5", generation: .fifth, engineColor: .green, capacity: 5, numberOfChildren: 4)
        ]

        for (index, train) in trains.enumerated() {
            train.cost = ((index + 1) * 4)
            assert(train.cost % 4 == 0)
        }

        return trains
    }

}

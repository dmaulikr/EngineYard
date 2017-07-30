//
//  GameBoard.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let boughtTrainNotificationId = Notification.Name("boughtTrainNotificationId")
}

final class GameBoard {

    // The game board is a series of spaces, representing
    fileprivate var _spaces: [Train] = [Train]()

    public var decks: [Train] {
        return self._spaces.sorted(by: { (t1:Train, t2:Train) -> Bool in
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
        self.unlockNext()
    }

    // MARK: - Prepare board

    // #TODO - Add callback
    public static func prepare() -> GameBoard {
        let gameBoard = GameBoard()

        // # load static game data fixtures
        //gameBoard._trains = LocomotiveAPI.loadFixtures()

        // # save to db (#TODO)

        return gameBoard
    }

    // Unlock next train
    private func unlockNext() {
        guard let firstLocked = (self.decks.filter({ (train: Train) -> Bool in
            return (train.isUnlocked == false)
        }).first) else {
            print ("No more trains to unlock")
            return
        }

        print ("Unlocking: \(firstLocked.name)")
        //firstLocked.orderBook.generateExistingOrders(howMany: 1)
    }

    func reset() {
        self._spaces.removeAll()
        removeNotifications()
    }
}

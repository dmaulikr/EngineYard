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

    fileprivate var _trains: [Locomotive] = [Locomotive]()

    public var decks: [Locomotive] {
        return self._trains.sorted(by: { (loco1:Locomotive, loco2:Locomotive) -> Bool in
            return (loco1.cost < loco2.cost)
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
        gameBoard._trains = LocomotiveAPI.loadFixtures()

        // # save to db (#TODO)

        return gameBoard
    }

    // Unlock next deck
    private func unlockNext() {
        guard let firstLocked = (self.decks.filter({ (loco:Locomotive) -> Bool in
            return (loco.isUnlocked == false)
        }).first) else {
            print ("No more locos to unlock")
            return
        }

        print ("Unlocking: \(firstLocked.name)")
        firstLocked.orderBook.generateExistingOrders(howMany: 1)
    }
    

    func reset() {
        self._trains.removeAll()
        removeNotifications()
    }

}

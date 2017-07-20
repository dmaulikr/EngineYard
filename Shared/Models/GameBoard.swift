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
    public fileprivate(set) lazy var decks: [Locomotive] = [Locomotive]()

    init() {
        registerNotification()
    }

    deinit {
        removeNotifications()
    }

    // MARK: - Register Notifications

    func registerNotification() {
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
        let gameBoard = GameBoard.init()

        // # load in data from disk
        gameBoard.decks = LocomotiveAPI.fetchLocomotives()

        // # save to db (TODO)

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
        let _ = firstLocked.orderBook.generateOrders(howMany: 1)
    }
    


}

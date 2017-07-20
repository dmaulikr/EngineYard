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
}

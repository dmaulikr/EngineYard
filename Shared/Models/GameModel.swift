//
//  GameModel.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class GameModel {
    static var instance = GameModel()

    private(set) var dateCreated: Date?

    var settings: GameConfig = GameConfig()
    var gameBoard: GameBoard = GameBoard() {
        didSet {
            self.dateCreated = Date.init(timeIntervalSinceNow: 0)
        }
    }
    var gameIsRunning : Bool {
        return (self.dateCreated != nil)
    }
}

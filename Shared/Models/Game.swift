//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Game {
    static var instance = Game()

    private(set) var dateCreated: Date?

    var settings: GameConfig = GameConfig()
    var gameBoard: GameBoard = GameBoard() {
        didSet {
            self.dateCreated = Date.init(timeIntervalSinceNow: 0)
        }
    }
    var inProgress : Bool {
        return (self.dateCreated != nil)
    }
    var turnOrderManager: TurnOrderManager = TurnOrderManager.instance
    var players: [Player] {
        return self.turnOrderManager.turnOrder
    }

}

extension Game {
    static public func setup(players:[Player]) -> Game? {
        do {
            let settings = GameConfig()

            guard let gameObj = try SetupManager.instance.setup(settings: settings, players: players) else {
                assertionFailure("no game model found")
                return nil
            }

            return gameObj
        } catch let error {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
}

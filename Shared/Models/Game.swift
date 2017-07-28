//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Game: CustomStringConvertible
{
    static var instance = Game()

    fileprivate(set) var dateCreated: Date?

    var lastKnownState: Int = 0
    var settings: GameConfig?
    var gameBoard: GameBoard? {
        didSet {
            guard let gameBoard = self.gameBoard else {
                return
            }
            if (gameBoard.decks.count > 0) {
                self.dateCreated = Date.init(timeIntervalSinceNow: 0)
            }
            else {
                self.dateCreated = nil
            }
        }
    }
    var inProgress : Bool {
        return (self.dateCreated != nil)
    }
    var turnOrderManager: TurnOrderManager = TurnOrderManager.instance
    var players: [Player] {
        return self.turnOrderManager.turnOrder
    }
    var description: String {
        var dateCreatedString = "N/A"
        if let dateCreated = self.dateCreated {
            dateCreatedString = String(describing: dateCreated)
        }
        return ("dateCreated: \(dateCreatedString), inProgress: \(self.inProgress), Players: \(self.players.count)")
    }
}

extension Game {
    
    public static func setup(players:[Player]) -> Game? {
        do {
            let settings = GameConfig()

            guard let game = try SetupManager.instance.setup(settings: settings, players: players) else {
                assertionFailure("no game model found")
                return nil
            }

            return game

        } catch let error {
            print (error.localizedDescription)
            assertionFailure(error.localizedDescription)
            return nil
        }
    }

    func abandon() {
        guard let gameBoard = self.gameBoard else {
            return
        }
        gameBoard.reset()
        self.gameBoard = nil
        self.dateCreated = nil
        self.turnOrderManager.turnOrder.removeAll()
        self.settings = nil
    }
}

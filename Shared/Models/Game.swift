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
    var description: String {
        var dateCreatedString = "N/A"
        if let dateCreated = self.dateCreated {
            dateCreatedString = String(describing: dateCreated)
        }
        return ("dateCreated: \(dateCreatedString), inProgress: \(self.inProgress), Players: \(self.players.count)")
    }

}

extension Game {
    public static func setup(players:[Player], completionClosure : @escaping ((_ Game:Game?)->())) {
        do {
            let settings = GameConfig()

            guard let game = try SetupManager.instance.setup(settings: settings, players: players) else {
                assertionFailure("no game model found")
                return
            }

            print ("Game: \(game)")

            waitFor(duration: 0.75, callback: { (completed:Bool) in
                if (completed) {
                    completionClosure(game)
                }
            })

        } catch let error {
            print (error.localizedDescription)
            assertionFailure(error.localizedDescription)
            completionClosure(nil)
        }
        
    }
}

//
//  Game.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class Game {

    weak var gameBoard: GameBoard? {
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

    var dateCreated: Date?

    var inProgress : Bool {
        return (self.dateCreated != nil)
    }

    var description: String {
        var dateCreatedString = "N/A"
        if let dateCreated = self.dateCreated {
            dateCreatedString = String(describing: dateCreated)
        }
        return ("dateCreated: \(dateCreatedString), inProgress: \(self.inProgress)")
    }
}

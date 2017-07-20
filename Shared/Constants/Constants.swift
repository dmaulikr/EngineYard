
//
//  Constants.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2016 Amarjit. All rights reserved.
//

import Foundation

// Game constants from manual
struct Constants {
    static let endCashGoal: Int = 300 // The (cashGoal + tax) is end-game trigger
    static let taxRate: Float = 0.10

    struct SeedCash {
        static let threePlayers: Int = 12
        static let fivePlayers: Int = 14
    }

    struct NumberOfPlayers {
        static let min: Int = 3
        static let max: Int = 5

        static func isValid(count:Int) throws -> Bool {
            guard ((Constants.NumberOfPlayers.min ... Constants.NumberOfPlayers.max).contains(count)) else {
                throw ErrorCode.invalidNumberOfPlayers
            }
            return true
        }
    }

    struct Board {
        static let trains: Int = 14
        static let engines: Int = 43

        // meta card numbers
        static func numberOfCardsForColor(color: EngineColor) -> Int {
            switch color {
            case .green:
                return 5
            case .red:
                return 4
            case .yellow:
                return 3
            case .blue:
                return 2
            }
        }
    }
}

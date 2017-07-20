//
//  ErrorCodes.swift
//  EngineYard
//
//  Created by Amarjit on 25/05/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

enum ErrorCode: Error, CustomStringConvertible {
    case notUnlocked
    case gameIsPaused
    case notYourTurn
    case alreadyOwnTrain
    case noOrders
    case trainIsObsolete
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
    case noEngineFound
    case noLocoFound
    case noPlayerFound
    case invalidNumberOfPlayers
    case invalidAction
    case __UNKNOWN__

    public var description: String {
        switch self {
        case .notUnlocked:
            let localizedDescription = NSLocalizedString("This train is not unlocked", comment: "notUnlocked message")
            return localizedDescription
        case .gameIsPaused:
            let localizedDescription = NSLocalizedString("The game is paused", comment: "gameIsPaused message")
            return localizedDescription
        case .notYourTurn:
            let localizedDescription = NSLocalizedString("It is not your turn", comment: "notYourTurn message")
            return localizedDescription
        case .alreadyOwnTrain:
            let localizedDescription = NSLocalizedString("You already own this train", comment: "alreadyOwnTrain message")
            return localizedDescription
        case .trainIsObsolete:
            let localizedDescription = NSLocalizedString("This train is obsolete", comment: "trainIsObsolete message")
            return localizedDescription
        case .insufficientFunds(let amount):
            let localizedDescription = NSLocalizedString("Insufficient funds \(amount)", comment: "insufficientFunds message")
            return localizedDescription
        case .outOfStock:
            let localizedDescription = NSLocalizedString("This train is out of stock", comment: "trainIsObsolete message")
            return localizedDescription
        case .noPlayerFound:
            let localizedDescription = NSLocalizedString("No player found", comment: "noPlayerFound message")
            return localizedDescription
        case .noEngineFound:
            let localizedDescription = NSLocalizedString("No engine found", comment: "noEngineFound message")
            return localizedDescription
        case .noLocoFound:
            let localizedDescription = NSLocalizedString("No locomotive found", comment: "noLocoFound message")
            return localizedDescription
        case .invalidNumberOfPlayers:
            let localizedDescription = NSLocalizedString("Invalid number of players", comment: "invalidPlayers message")
            return localizedDescription
        case .invalidAction:
            let localizedDescription = NSLocalizedString("Invalid Action", comment: "invalidAction message")
            return localizedDescription
        default:
            return ""
        }
    }
}

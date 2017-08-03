//
//  ErrorCodes.swift
//  EngineYard
//
//  Created by Amarjit on 25/05/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

enum ErrorCode: Error {
    case noGameObjectDefined
    case noGameBoardDefined
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

    public var localizedDescription: String {
        switch self {
        case .noGameObjectDefined:
            return NSLocalizedString("** No game object defined **", comment: "System-error: No game object defined message")

        case .noGameBoardDefined:
            return NSLocalizedString("** No game board defined **", comment: "System-error: No game board defined message")


        case .notUnlocked:
            return  NSLocalizedString("This train is not unlocked", comment: "notUnlocked message")
            
        case .gameIsPaused:
            return  NSLocalizedString("The game is paused", comment: "gameIsPaused message")
            
        case .notYourTurn:
            return  NSLocalizedString("It is not your turn", comment: "notYourTurn message")
            
        case .alreadyOwnTrain:
            return  NSLocalizedString("You already own this train", comment: "alreadyOwnTrain message")
            
        case .trainIsObsolete:
            return  NSLocalizedString("This train is obsolete", comment: "trainIsObsolete message")
            
        case .insufficientFunds(let amount):
            return  NSLocalizedString("Insufficient funds \(amount)", comment: "insufficientFunds message")
            
        case .outOfStock:
            return  NSLocalizedString("This train is out of stock", comment: "trainIsObsolete message")
            
        case .noPlayerFound:
            return  NSLocalizedString("No player found", comment: "noPlayerFound message")
            
        case .noEngineFound:
            return  NSLocalizedString("No engine found", comment: "noEngineFound message")
            
        case .noLocoFound:
            return  NSLocalizedString("No locomotive found", comment: "noLocoFound message")
            
        case .invalidNumberOfPlayers:
            return  NSLocalizedString("Invalid number of players", comment: "invalidPlayers message")
            
        case .invalidAction:
            return  NSLocalizedString("Invalid Action", comment: "invalidAction message")
            
        default:
            return ""
        }
    }
}

extension ErrorCode: Equatable
{
    public static func == (lhs: ErrorCode, rhs: ErrorCode) -> Bool {
        switch (lhs, rhs) {
        case (.notUnlocked, .notUnlocked):
            return true

        case  (.insufficientFunds, .insufficientFunds):
            return true

        default:
            return false;
        }
    }
}

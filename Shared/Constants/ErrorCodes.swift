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
    case noPlayerFound
    case invalidNumberOfPlayers
    case gameIsPaused
    case notYourTurn
    case trainIsObsolete
    case trainIsRusting
    case insufficientFunds(coinsNeeded: Int)

    case trainIsNotUnlocked(train: Train)
    case trainHasNoStockRemaining(train: Train)
    case playerAlreadyOwns(train: Train)

    case invalidAction
    case __UNKNOWN__

    public var localizedDescription: String {
        switch self {
        case .noGameObjectDefined:
            return NSLocalizedString("** No game object defined **", comment: "System-error: No game object defined message")

        case .noGameBoardDefined:
            return NSLocalizedString("** No game board defined **", comment: "System-error: No game board defined message")

        case .noPlayerFound:
            return  NSLocalizedString("No player found", comment: "noPlayerFound message")


        case .invalidNumberOfPlayers:
            return  NSLocalizedString("Invalid number of players", comment: "invalidPlayers message")

        case .gameIsPaused:
            return  NSLocalizedString("The game is paused", comment: "gameIsPaused message")
            
        case .notYourTurn:
            return  NSLocalizedString("It is not your turn", comment: "notYourTurn message")

        case .trainIsObsolete:
            return  NSLocalizedString("This train is obsolete", comment: "trainIsObsolete message")

        case .playerAlreadyOwns(let train):
            return NSLocalizedString("You already own \(train.name)", comment: "Already own train mesage")

        case .trainIsNotUnlocked(let train):
            return NSLocalizedString("\(train.name) is not available for purchase", comment: "Not unlocked message")

        case .trainHasNoStockRemaining(let train):
            return NSLocalizedString("\(train.name) has no cards remaining", comment: "No stock remaining message")

        case .insufficientFunds(let amount):
            return  NSLocalizedString("Insufficient funds \(amount)", comment: "insufficientFunds message")

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
        
        case  (.insufficientFunds, .insufficientFunds):
            return true

        default:
            return false;
        }
    }
}

//
//  BaseViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class BaseViewModel : CustomStringConvertible {
    weak var game: Game?

    init(game: Game) {
        self.game = game

        guard let hasGame = self.game else {
            assertionFailure(ErrorCode.noGameObjectDefined.localizedDescription)
            return
        }

        guard let _ = hasGame.gameBoard else {
            assertionFailure(ErrorCode.noGameBoardDefined.localizedDescription)
            return
        }

        print (description)
    }
}

extension BaseViewModel {

    func checkGameObject(game: Game?) -> Game? {
        do {
            guard let hasGame = try self.validateGameObject(game: game) else {
                assertionFailure("no game model found")
                return nil
            }

            return hasGame
        } catch let error {
            print (error.localizedDescription)
        }

        return nil
    }

    func validateGameObject(game: Game?) throws -> Game?
    {
        guard let hasGame = game else {
            throw ErrorCode.noGameObjectDefined
        }

        guard let _ = hasGame.gameBoard else {
            throw ErrorCode.noGameBoardDefined
        }
        
        return hasGame
    }

}

extension BaseViewModel {
    var description: String {
        guard let hasGame = self.game else {
            return ErrorCode.noGameObjectDefined.localizedDescription as String
        }

        guard let hasGameBoard = hasGame.gameBoard else {
            return ErrorCode.noGameBoardDefined.localizedDescription as String
        }

        return ("\(hasGame.description), decks: \(hasGameBoard.decks.count)")
    }
}


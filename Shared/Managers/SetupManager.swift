//
//  SetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class SetupManager
{
    static var instance = SetupManager()

    func setup(settings: GameConfig, players: [Player]) throws -> Game? {

        do {
            if try Constants.NumberOfPlayers.isValid(count: players.count)
            {
                let gameObj = Game.init()

                // prepare board
                gameObj.gameBoard = GameBoard.prepare()
                gameObj.turnOrderManager.turnOrder = players
                gameObj.settings = settings

                if (settings.shouldShuffleTurnOrder) {
                    gameObj.turnOrderManager.shuffleTurnOrder()
                }

                // setup players
                switch players.count {
                case 3...4:
                    setupThreePlayerGame(gameModel: gameObj)
                    break
                case 5:
                    setupFivePlayerGame(gameModel: gameObj)
                    break

                default:
                    assertionFailure("Error -- Invalid number of players")
                    break
                }

                return gameObj
            }
            else {
                return nil
            }

        } catch let error {
            print (error.localizedDescription)
            return nil
        }
        
    }
 
}



extension SetupManager
{
    // # Setup for 3-4 players:
    // Give each player 12 coins and
    // one unowned First Generation Green locomotive card.
    // Each player places one Production Unit counter
    // on the locomotive card, with side “1” face up.

    fileprivate func setupThreePlayerGame(gameModel:Game) {
        let seedCash = Constants.SeedCash.threePlayers
        let players = gameModel.turnOrderManager.turnOrder
        gameModel.turnOrderManager.turnOrder = PlayerAPI.setSeedCash(players: players, amount: seedCash)

        assert(gameModel.players.count > 0, "No players were defined")

        guard let gameBoard = gameModel.gameBoard else {
            assertionFailure("GameBoard is not defined")
            return
        }

        // Get first 2 decks
        let decks = gameBoard.decks[0...1]

        guard let firstTrain = decks.first else {
            assertionFailure("No first train found")
            return
        }

        guard let lastTrain = decks.last else {
            assertionFailure("No last train found")
            return
        }

        assert(firstTrain.generation == .first && firstTrain.engineColor == .green)
        assert(lastTrain.generation == .first && lastTrain.engineColor == .red)

        // Give each player a first train card (if possible)

        for player in gameModel.players {
            let _ = player.hand.add(train: firstTrain)
        }

        firstTrain.orderBook.generateExistingOrders(howMany: 3)
        lastTrain.orderBook.generateExistingOrders(howMany: 1)
    }


    //    # Setup for 5 players:
    //    + Give each player 14 coins.
    //    + No one starts with a locomotive card in play.
    //    + Roll only 1 die and place it in the Initial Orders
    //    area of the First Generation of the green Passenger locomotive.

    fileprivate func setupFivePlayerGame(gameModel:Game) {

        assert(gameModel.players.count > 0, "# Players invalid")
        let seedCash = Constants.SeedCash.fivePlayers
        let players = gameModel.turnOrderManager.turnOrder
        gameModel.turnOrderManager.turnOrder = PlayerAPI.setSeedCash(players: players, amount: seedCash)

        guard let gameBoard = gameModel.gameBoard else {
            assertionFailure("GameBoard is not defined")
            return
        }

        guard let firstTrain = gameBoard.decks.first else {
            assertionFailure("firstTrain does not exist")
            return
        }
        assert(firstTrain.generation == .first && firstTrain.engineColor == .green)

        firstTrain.orderBook.generateExistingOrders(howMany: 1)
    }
    
    
}

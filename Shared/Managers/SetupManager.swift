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

        let decks = gameBoard.decks

        guard let firstTrain = TrainAPI.findTrainInDeck(decks: decks, whereColor: .green, whereGeneration: .first) else {
            assertionFailure("Cannot find first train in deck that matches (green, first)")
            return
        }

        let filter = firstTrain.cards.filter({
            $0.owner == nil
        })

        assert(filter.count > 0, "Cards returned is invalid")

//
//        for player in gameModel.players {
//            guard let firstUnownedEngine = enginesList.filter({ (eng:Engine) -> Bool in
//                return (eng.owner == nil)
//            }).first else {
//                fatalError("Cannot find any unowned engine for \(firstLoco.name)")
//                break
//            }
//
//            firstUnownedEngine.assignOwner(player: player)
//        }

        /*

        // Give each player first generation green train
        for player in gameModel.players {
            guard let firstUnownedEngine = enginesList.filter({ (eng:Engine) -> Bool in
                return (eng.owner == nil)
            }).first else {
                fatalError("Cannot find any unowned engine for \(firstLoco.name)")
                break
            }

            firstUnownedEngine.assignOwner(player: player)
        }

        // generate 3 orders for firstLoco
        print ("Generating orders for \(firstLoco.name)")
        firstLoco.orderBook.generateExistingOrders(howMany: 3)

        // generate 1 order for secondLoco
        let secondLoco:Locomotive = decks[1] as Locomotive
        if ((secondLoco.generation != .first) && (secondLoco.engineColor != .red)) {
            assertionFailure("Second loco is invalid")
        }
        secondLoco.orderBook.generateExistingOrders(howMany: 1)
         */
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

        /*
        let decks = gameBoard.decks

        guard let firstLoco = LocomotiveAPI.findLocomotiveInDeck(decks: decks, whereColor: .green, whereGeneration: .first) else {
            return
        }

        // Generate 1 orders for firstLoco
        print ("Generating orders for \(firstLoco.name)")
        firstLoco.orderBook.generateExistingOrders(howMany: 1)
         */
    }
    
    
}

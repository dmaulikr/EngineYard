//
//  SetupManager.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class SetupManager : NSObject {
    static var instance = SetupManager()

    // #TODO - Add callback for completion or nil
    func setup(settings:GameConfig, players:[Player]) throws -> Game? {

        do {
            if try Constants.NumberOfPlayers.isValid(count: players.count)
            {
                let gameModel = Game.init()

                // prepare board
                gameModel.gameBoard = GameBoard.prepare()                                
                gameModel.turnOrderManager.turnOrder = players

                if (settings.shouldShuffleTurnOrder) {
                    gameModel.turnOrderManager.shuffleTurnOrder()
                }

                // setup players
                switch players.count {
                case 3...4:
                    setupThreePlayerGame(gameModel:gameModel)
                    break
                case 5:
                    setupFivePlayerGame(gameModel:gameModel)
                    break

                default:
                    assertionFailure("Error -- Invalid number of players")
                    break
                }

                return gameModel
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

        let decks = gameModel.gameBoard.decks

        guard let firstLoco = LocomotiveAPI.findLocomotiveInDeck(decks: decks, whereColor: .green, whereGeneration: .first) else {
            return
        }

        let enginesList = firstLoco.engines.filter({
            $0.owner == nil
        })

        if (enginesList.count == 0) {
            return
        }

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
        let _ = firstLoco.orderBook.generateExistingOrders(howMany: 3)

        // generate 1 order for secondLoco
        let secondLoco:Locomotive = decks[1] as Locomotive
        if ((secondLoco.generation != .first) && (secondLoco.engineColor != .red)) {
            assertionFailure("Second loco is invalid")
        }
        let _ = secondLoco.orderBook.generateExistingOrders(howMany: 1)
    }


    //    # Setup for 5 players:
    //    + Give each player 14 coins.
    //    + No one starts with a locomotive card in play.
    //    + Roll only 1 die and place it in the Initial Orders
    //    area of the First Generation of the green Passenger locomotive.

    fileprivate func setupFivePlayerGame(gameModel:Game) {

        let seedCash = Constants.SeedCash.fivePlayers
        let players = gameModel.turnOrderManager.turnOrder
        gameModel.turnOrderManager.turnOrder = PlayerAPI.setSeedCash(players: players, amount: seedCash)

        let decks = gameModel.gameBoard.decks

        guard let firstLoco = LocomotiveAPI.findLocomotiveInDeck(decks: decks, whereColor: .green, whereGeneration: .first) else {
            return
        }

        // Generate 1 orders for firstLoco
        print ("Generating orders for \(firstLoco.name)")
        let _ = firstLoco.orderBook.generateExistingOrders(howMany: 1)
    }
    

}

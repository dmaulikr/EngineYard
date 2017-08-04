//
//  TrainPurchaseTests.swift
//  EngineYard
//
//  Created by Amarjit on 04/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TrainPurchaseTests: BaseTests {

    var game: Game!
    var train: Train!

    override func setUp() {
        super.setUp()

        guard let players = Mock.players(howMany: 5) else {
            XCTFail("Mock players failed")
            return
        }
        XCTAssert(players.count == 5)

        guard let game = Game.setup(players: players) else {
            XCTFail("Game setup failed")
            return
        }

        guard let gameBoard = game.gameBoard else {
            XCTFail("No game board defined")
            return
        }

        guard let firstTrain = gameBoard.decks.first else {
            XCTFail("No train found")
            return
        }

        self.game = game
        self.train = firstTrain
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // I expect to be able to purchase a train, unlocks the next train, 
    // adds the train to a player's hand and debits the player's wallet
    func testPurchaseTrain() {

        XCTAssertTrue(train.generation == .first && train.engineColor == .green)
        XCTAssertTrue(game.players.count == Constants.NumberOfPlayers.max)

        guard let firstPlayer = game.players.first else {
            XCTFail("no player found")
            return
        }


        // checks
        // 1. Train is unlocked, has orders
        // 2. There is stock available
        // 3. Player can afford train
        // 4. Player doesn't already have the train in his hand


        // I expect that all trains except first are invalid purchases

        let _ = game.gameBoard?.decks.map({
            do {
                let result = try $0.canBePurchased(by: firstPlayer)
                XCTAssertTrue(result)

            } catch let error {
                print (error)
            }
        })

        XCTAssertTrue(countInvalidPurchase == (Constants.Board.decks - 1))

    }

}

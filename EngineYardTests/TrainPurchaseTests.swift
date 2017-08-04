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

    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // I expect to be able to purchase a train, unlocks the next train, 
    // adds the train to a player's hand and debits the player's wallet
    func testPurchaseTrain() {


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

        guard let train = game.gameBoard?.decks.first else {
            XCTFail("No train found")
            return
        }

        guard let firstPlayer = game.players.first else {
            XCTFail("no player found")
            return
        }


        XCTAssertTrue(train.generation == .first && train.engineColor == .green)
        XCTAssertTrue(game.players.count == Constants.NumberOfPlayers.max)


        // Checks
        // 1. Train is unlocked, has orders
        // 2. There is stock available
        // 3. Player can afford train
        // 4. Player doesn't already have the train in his hand

        // I expect that all trains except first are invalid purchases

        var invalidPurchases: Int = 0
        let _ = game.gameBoard?.decks.map({


            let (result, error) = TrainAPI
                .isValidPurchase(train: $0, player: firstPlayer)

            if let error = error {
                print(error)
                invalidPurchases += 1
            }
            else {
                XCTAssertTrue(result)
            }
        })


        XCTAssertTrue(invalidPurchases == 13)

    }


}

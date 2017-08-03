//
//  PlayerTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class PlayerTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMockPlayerSetup() {
        XCTAssertNil( Mock.players(howMany: 1) )
        XCTAssertNil( Mock.players(howMany: 6) )

        guard let players = Mock.players(howMany: 5) else {
            XCTFail("Mock players failed")
            return
        }
        XCTAssert(players.count == 5)
    }

    func testThreePlayerSetup() {
        let howMany = 3
        guard let players = Mock.players(howMany: howMany) else {
            XCTFail("Mock players failed")
            return
        }
        XCTAssert(players.count == howMany)

        guard let game = Game.setup(players: players) else {
            XCTFail("Game setup failed")
            return
        }
        XCTAssert(game.players.count == howMany)

        guard let gameBoard = game.gameBoard else {
            XCTFail("Game board setup failed")
            return
        }

        let hasOrders = gameBoard.decks.filter { (train: Train) -> Bool in
            return (train.orderBook.existingOrders.count > 0)
        }

        XCTAssert(hasOrders.count == 2)

        for (index, train) in hasOrders.enumerated() {
            if (index == 0) {
                XCTAssert(train.owners?.count == 3)
            }
            else {
                XCTAssert(train.owners?.count == 0)
            }
        }

        // players
        let _ = game.players.map({
            XCTAssert($0.wallet.balance == Constants.SeedCash.threePlayers)
            XCTAssert($0.hand.cards.count == 1)
        })

        for player in game.players {
            for card in player.hand.cards {
                XCTAssertNotNil(card.production)
                XCTAssertNotNil(card.parent)
                XCTAssertNotNil(card.owner)

                XCTAssert(card.owner == player)
                XCTAssert(card.production?.units == 1)
                XCTAssert(card.parent?.engineColor == .green)
                XCTAssert(card.parent?.generation == .first)
            }
        }
    }

    func testFivePlayerSetup() {
        let howMany = 5
        guard let players = Mock.players(howMany: howMany) else {
            XCTFail("Mock players failed")
            return
        }
        XCTAssert(players.count == howMany)

        guard let game = Game.setup(players: players) else {
            XCTFail("Game setup failed")
            return
        }
        XCTAssert(game.players.count == howMany)

        guard let gameBoard = game.gameBoard else {
            XCTFail("Game board setup failed")
            return
        }

        let results = gameBoard.decks.filter { (t:Train) -> Bool in
            return (t.orderBook.existingOrders.count > 0)
        }

        XCTAssert(results.count == 1)

        guard let firstTrain = results.first else {
            return
        }

        XCTAssert(firstTrain.existingOrderValues.count == 1)
        XCTAssert(firstTrain.engineColor == .green)
        XCTAssert(firstTrain.generation == .first)

        let _ = game.players.map({
            XCTAssert($0.wallet.balance == Constants.SeedCash.fivePlayers)
            XCTAssert($0.hand.cards.count == 0)
        })


        let _ = gameBoard.decks.map({
            XCTAssert($0.owners?.count == 0)
        })


    }


}

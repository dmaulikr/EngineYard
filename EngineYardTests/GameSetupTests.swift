//
//  GameSetupTests.swift
//  EngineYard
//
//  Created by Amarjit on 21/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class GameSetupTests: BaseTests {

    var gameObj: Game?

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Expected: 
    // $12 coins seed cash
    // Each player gets 1x Green.1 engine, each with 1x production unit
    // First two trains have orders, rest do not
    func testThreePlayerSetup() {
        let howMany = 3
        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: howMany) else {
            return
        }
        XCTAssert(mockPlayers.count == howMany)

        /**

        guard let gameObj = Game.setup(players: mockPlayers) else {
            return
        }
        self.gameObj = gameObj

        XCTAssert(gameObj.players.count == 3)

        _ = self.gameObj.players.map({
            XCTAssert($0.account.balance == Constants.SeedCash.threePlayers)
            XCTAssert($0.engines.count == 1)
        })

        for player in self.gameObj.players {
            for engine in player.engines {
                XCTAssert(engine.owner == player)
                XCTAssert(engine.production.units == 1)
                XCTAssert(engine.parent?.engineColor == .green)
                XCTAssert(engine.parent?.generation == .first)
            }
        }

        let validDecks = (gameObj.gameBoard.decks.filter({ (loco:Locomotive) -> Bool in
            return (loco.existingOrders.count > 0)
        }).count)

        XCTAssert(validDecks == 2)
         **/
    }

    // Expected:
    // $14 coins seed cash
    // No-one has any engine cards
    // First train has orders, rest do not
    func testFivePlayerSetup() {
        let howMany = 5
        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: howMany) else {
            return
        }
        XCTAssert(mockPlayers.count == howMany)

        /**
        guard let gameObj = Game.setup(players: mockPlayers) else {
            return
        }
        self.gameObj = gameObj

        XCTAssert(gameObj.players.count == 5)

        _ = self.gameObj.players.map({
            XCTAssert($0.account.balance == Constants.SeedCash.fivePlayers)
            XCTAssert($0.engines.count == 0)
        })

        for (index, loco) in self.gameObj.gameBoard.decks.enumerated() {
            if (index == 0) {
                XCTAssert(loco.existingOrders.count == 1)
            }
            else {
                XCTAssert(loco.existingOrders.count == 0)
            }
        }

        let validDecks = (gameObj.gameBoard.decks.filter({ (loco:Locomotive) -> Bool in
            return (loco.existingOrders.count > 0)
        }).count)

        XCTAssert(validDecks == 1)
         **/
    }
}

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

    var gameObj: Game!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testThreePlayerSetup() {
        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: 3) else {
            return
        }

        guard let gameObj = Game.setup(players: mockPlayers) else {
            return
        }
        self.gameObj = gameObj

        XCTAssert(gameObj.players.count == 3)

        _ = self.gameObj.players.map({
            XCTAssert($0.account.balance == Constants.SeedCash.threePlayers)
            XCTAssert($0.engines.count == 1)
        })
    }

    func testFivePlayerSetup() {
        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: 5) else {
            return
        }

        guard let gameObj = Game.setup(players: mockPlayers) else {
            return
        }
        self.gameObj = gameObj

        XCTAssert(gameObj.players.count == 5)

        _ = self.gameObj.players.map({
            XCTAssert($0.account.balance == Constants.SeedCash.fivePlayers)
            XCTAssert($0.engines.count == 0)
        })
    }
}

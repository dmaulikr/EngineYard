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

    }

    func testFivePlayerSetup() {
        guard let players = Mock.players(howMany: 5) else {
            XCTFail("Mock players failed")
            return
        }
        XCTAssert(players.count == 5)

        guard let game = Game.setup(players: players) else {
            XCTFail("Game setup failed")
            return
        }

        XCTAssert(game.players.count == 5)

        let _ = game.players.map({
            XCTAssert($0.wallet.balance == Constants.SeedCash.fivePlayers)
        })
    }


}

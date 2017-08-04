//
//  TrainUnlockTests.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TrainUnlockTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testMassUnlocking() {
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

        let numberOfTrue = gameBoard.countUnlocked
        XCTAssert(numberOfTrue == 1, "\(numberOfTrue)")

        // force clear & generate orders
        var unlocked = 0
        for t in gameBoard.decks {
            t.orderBook.clear()
            t.orderBook.generateExistingOrders(howMany: 1)
            if (t.isUnlocked) {
                unlocked += 1
            }
        }

        let valid = gameBoard.countUnlocked
        XCTAssertTrue(valid == Constants.Board.decks, "\(valid)")
        XCTAssertTrue(valid == unlocked, "\(valid) vs \(unlocked)")

    }


}

//
//  PurchaseTrainTests.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class PurchaseTrainTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPurchaseTrain_ThrowsCannotAfford() {

        let howMany = 3
        guard let players = Mock.players(howMany: howMany) else {
            XCTFail("Mock players failed")
            return
        }

        guard let game = Game.setup(players: players) else {
            XCTFail("Game setup failed")
            return
        }

        guard let gameBoard = game.gameBoard else {
            XCTFail("No game board defined")
            return
        }

        // force unlock all
        for t in gameBoard.decks {
            t.orderBook.clear()
            t.orderBook.generateExistingOrders(howMany: 1)
        }

        guard let train = gameBoard.decks.last else {
            XCTFail("No train found")
            return
        }

        guard let buyer = players.first else {
            XCTFail("No buyer found")
            return
        }

        XCTAssertThrowsError(try train.canPurchase(buyer: buyer)) { (error) -> Void in
            XCTAssertEqual(error as? ErrorCode, ErrorCode.insufficientFunds(coinsNeeded: train.cost))
        }
    }

    func testPurchaseTrain_ThrowsAlreadyPurchased()
    {
        let howMany = 3
        guard let players = Mock.players(howMany: howMany) else {
            XCTFail("Mock players failed")
            return
        }

        guard let game = Game.setup(players: players) else {
            XCTFail("Game setup failed")
            return
        }

        guard let gameBoard = game.gameBoard else {
            XCTFail("No game board defined")
            return
        }

        guard let train = gameBoard.decks.first else {
            XCTFail("No train found")
            return
        }

        guard let buyer = players.first else {
            XCTFail("No buyer found")
            return
        }

        XCTAssertThrowsError(try train.canPurchase(buyer: buyer)  )
    }

}

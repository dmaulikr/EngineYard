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

        guard let _ = gameBoard.decks.last else {
            XCTFail("No train found")
            return
        }

        guard let _ = players.first else {
            XCTFail("No buyer found")
            return
        }

        /*
        XCTAssertThrowsError(try train.canPurchase(buyer: buyer)) { (error) -> Void in
            XCTAssertEqual(error as? ErrorCode, ErrorCode.insufficientFunds(coinsNeeded: train.cost))
        }*/
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

        guard let _ = gameBoard.decks.first else {
            XCTFail("No train found")
            return
        }

        guard players.first != nil else {
            XCTFail("No buyer found")
            return
        }

        // XCTAssertThrowsError(try train.canPurchase(buyer: buyer)  )
    }

    func testPurchaseUnlocksNextTrain() {
        let howMany = 5
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

        guard let buyer = players.first else {
            XCTFail("No buyer found")
            return
        }

        guard let train = (gameBoard.decks.filter { (t: Train) -> Bool in
            return (t.isUnlocked)
        }.first) else {
            XCTFail("No train found")
            return
        }

        XCTAssertTrue(train.generation == .first)
        XCTAssertTrue(train.engineColor == .green)

        let count = TrainAPI.countUnlockedDecks(in: gameBoard)
        XCTAssertTrue(count == 1)
        XCTAssertTrue(train.owners?.count == 0)
        XCTAssertTrue(buyer.hand.cards.count == 0)

        /*
        let cashBefore = buyer.wallet.balance
        train.purchase(buyer: buyer)
        let cashAfter = buyer.wallet.balance
        XCTAssertTrue(cashAfter == (cashBefore - train.cost))
        XCTAssertTrue(buyer.hand.cards.count == 1)
        */

        train.purchase(buyer: buyer)





    }

}

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

        let count = TrainAPI.countUnlockedDecks(in: gameBoard)
        XCTAssertTrue(count == 1)
        XCTAssertTrue(train.owners?.count == 0)
        XCTAssertTrue(buyer.hand.cards.count == 0)

        let cashBefore = buyer.wallet.balance
        train.purchase(buyer: buyer)
        let cashAfter = buyer.wallet.balance
        XCTAssertTrue(cashAfter == (cashBefore - train.cost))

        XCTAssertTrue(buyer.hand.cards.count == 1)

        guard let firstHandItem = buyer.hand.cards.first else {
            XCTFail("No cards in hand")
            return
        }

        guard let firstCardInDeck = train.cards.first else {
            XCTFail("No firstCardInDeck")
            return
        }

        XCTAssertTrue(firstHandItem == firstCardInDeck)
        XCTAssertTrue(firstCardInDeck.owner == buyer)
        XCTAssertTrue(firstCardInDeck.parent == train)

        XCTAssertTrue(firstHandItem.production.units == 1)
        XCTAssertTrue(firstHandItem.production.unitsSpent == 0)

        var counter = 0
        for train in gameBoard.decks {
            if (train.isUnlocked) {
                counter += 1
            }
        }

        XCTAssertTrue(counter == 2, "\(counter)")



    }

}

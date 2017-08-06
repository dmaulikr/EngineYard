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

    func testNotifySubscribers() {
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
            XCTFail("no train found")
            return
        }

        firstTrain.notifySubscribers()
        XCTAssert(gameBoard.countUnlocked == 2)

        let filtered = gameBoard.decks.filter({
            return ($0.isUnlocked)
        })

        XCTAssertTrue((filtered.count == gameBoard.countUnlocked) && (filtered.count == 2))
        XCTAssertTrue(filtered.first?.generation == .first && filtered.first?.engineColor == .green)
        XCTAssertTrue(filtered.last?.generation == .first && filtered.last?.engineColor == .red)
    }

    func testNotifyAllSubscribers() {
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

        let _ = gameBoard.decks.map({
            $0.notifySubscribers()
        })

        XCTAssert(gameBoard.countUnlocked == Constants.Board.decks)

        let _ = gameBoard.decks.map({
            XCTAssert($0.orderBook.existingOrders.count == 1)
        })
    }

    func testPlayerPurchasesTrain()
    {
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
            XCTFail("no train found")
            return
        }
        guard let firstPlayer = game.players.first else {
            XCTFail("no 1st player found")
            return
        }

        XCTAssertTrue(firstPlayer.hand.cards.count == 0)
        let cashBefore = firstPlayer.wallet.balance
        let cashAfter = (cashBefore - firstTrain.cost)

        XCTAssertTrue(firstPlayer.wallet.canAfford(amount: firstTrain.cost))

        do {
            let result = try firstTrain.canBePurchased(by: firstPlayer)

            if (result)
            {
                firstTrain.purchase(buyer: firstPlayer)

                XCTAssertTrue(gameBoard.countUnlocked == 2)
                XCTAssertTrue(firstPlayer.wallet.balance == cashAfter)
                XCTAssertTrue(firstPlayer.hand.cards.count == 1)
                XCTAssertTrue(firstTrain.owners?.count == 1)

                guard let firstOwner = firstTrain.owners?.first else {
                    XCTFail("no owner found")
                    return
                }

                XCTAssertTrue(firstOwner == firstPlayer)
            }

        } catch let error {
            XCTFail(error as! String)
            return
        }


    }

}

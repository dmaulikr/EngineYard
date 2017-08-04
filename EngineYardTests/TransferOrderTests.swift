//
//  TransferOrderTests.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TransferOrderTests: BaseTests {

    var game: Game!
    var gameBoard: GameBoard!

    override func setUp() {
        super.setUp()

        let howMany = 5
        guard let players = Mock.players(howMany: howMany) else {
            XCTFail("Mock players failed")
            return
        }

        guard let game = Game.setup(players: players) else {
            XCTFail("Game setup failed")
            return
        }
        self.game = game

        guard let gameBoard = game.gameBoard else {
            XCTFail("No game board defined")
            return
        }
        self.gameBoard = gameBoard

        let numberOfTrue = gameBoard.countUnlocked 
        XCTAssertTrue(numberOfTrue == 1)
    }

    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTransferExistingOrdersToComplete()
    {
        let firstTrain = gameBoard.decks.first!
        XCTAssertTrue(firstTrain.orderBook.existingOrders.count == 1)
        XCTAssertTrue(firstTrain.orderBook.completedOrders.count == 0)

        let firstExistingOrder = firstTrain.orderBook.existingOrders.first!
        let value = firstExistingOrder.value
        firstTrain.orderBook.transferOrder(order: firstExistingOrder, index: 0)

        XCTAssertTrue(firstTrain.orderBook.existingOrders.count == 0)
        XCTAssertTrue(firstTrain.orderBook.completedOrders.count == 1)
        XCTAssertTrue(firstTrain.orderBook.completedOrders.first?.value == value)
    }

    func testRerollAndTransfer() {
        let firstTrain = gameBoard.decks.first!
        XCTAssertTrue(firstTrain.orderBook.existingOrders.count == 1)
        XCTAssertTrue(firstTrain.orderBook.completedOrders.count == 0)

        let firstExistingOrder = firstTrain.orderBook.existingOrders.first!
        firstTrain.orderBook.transferOrder(order: firstExistingOrder, index: 0)

        XCTAssertTrue(firstTrain.orderBook.existingOrders.count == 0)
        XCTAssertTrue(firstTrain.orderBook.completedOrders.count == 1)

        firstTrain.orderBook.rerollAndTransferCompletedOrders()

        XCTAssertTrue(firstTrain.orderBook.existingOrders.count == 1)
        XCTAssertTrue(firstTrain.orderBook.completedOrders.count == 0)


    }

    
}

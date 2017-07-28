//
//  TransferOrderTests.swift
//  EngineYard
//
//  Created by Amarjit on 24/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TransferOrderTests: BaseTests {

    var gameObj: Game!
    var gameBoard: GameBoard = GameBoard.init()
    var trains: [Locomotive] = [Locomotive]()

    override func setUp() {
        super.setUp()

        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: 5) else {
            XCTFail("No mock players found")
            return
        }

        guard let gameObj = Game.setup(players: mockPlayers) else {
            XCTFail("No game object")
            return
        }
        guard let gameBoard = gameObj.gameBoard else {
            XCTFail("No game board defined")
            return
        }

        self.gameObj = gameObj
        self.gameBoard = gameBoard
        self.trains = gameBoard.decks

    }

    override func tearDown() {
        super.tearDown()
    }

    func testTransferOrders() {
        XCTAssert(self.trains.count == Constants.Board.decks)

        // force unlock first train
        guard let firstTrain = trains.first else {
            XCTFail("No train found")
            return
        }

        XCTAssert(firstTrain.orderBook.existingOrders.count == 1)

        let trainsWithOrders = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
        }

        XCTAssert(trainsWithOrders.count == 1)

        guard let firstTrainWithOrder = trainsWithOrders.first else {
            return
        }

        XCTAssert(firstTrainWithOrder.engineColor == .green)
        XCTAssert(firstTrainWithOrder.generation == .first)

        XCTAssert(firstTrainWithOrder.orderBook.existingOrders.count == 1)
        XCTAssert(firstTrainWithOrder.orderBook.completedOrders.count == 0)

        guard let existingOrder = firstTrainWithOrder.orderBook.existingOrders.first else {
            XCTFail("No order found in existingOrders")
            return
        }

        firstTrainWithOrder.orderBook.transferOrder(order: existingOrder, index: 0)
    }

}

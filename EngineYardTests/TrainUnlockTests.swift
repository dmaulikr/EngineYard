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

        for (index, train) in gameBoard.decks.enumerated() {
            print ("index: #\(index) - \(train.name), \(train.isUnlocked), \(train.existingOrders), \(train.completedOrders)")
        }

        let numberOfTrue = TrainAPI.countUnlockedDecks(in: gameBoard)
        XCTAssert(numberOfTrue == 1, "\(numberOfTrue)")

        if let nextTrain = TrainAPI.getNextLockedDeck(in: gameBoard) {


            print ("NXT TRAIN > \(nextTrain.name), \(nextTrain.isUnlocked), \(nextTrain.existingOrders), \(nextTrain.completedOrders)")

        }
        else {
            XCTFail("no next train")
        }


        


        /**

        // force clear & generate orders
        for t in gameBoard.decks {
            t.orderBook.clear()
            t.orderBook.generateExistingOrders(howMany: 1)
        }

        numberOfTrue = TrainAPI.countUnlockedDecks(in: gameBoard)
        XCTAssert(numberOfTrue == Constants.Board.decks, "\(numberOfTrue)")

        XCTAssertNil(gameBoard.nextDeckToUnlock())

        **/
    }


}

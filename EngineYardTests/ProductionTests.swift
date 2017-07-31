//
//  ProductionTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class ProductionTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testProductionUnits() {
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

        let numberOfTrue = TrainAPI.countUnlockedDecks(in: gameBoard)
        XCTAssertTrue(numberOfTrue == 1)

        guard let train = gameBoard.decks.first else {
            XCTFail("No train found")
            return
        }

        guard let buyer = players.first else {
            XCTFail("No buyer found")
            return
        }

        //train.purchase(buyer: buyer)

    }





}

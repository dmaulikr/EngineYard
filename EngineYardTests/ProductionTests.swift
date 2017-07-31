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

        let numberOfTrue = TrainAPI.countUnlockedDecks(in: gameBoard)
        XCTAssertTrue(numberOfTrue == 1)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testProductionUnits() {
        let players = game.players

        guard let train = gameBoard.decks.first else {
            XCTFail("No train found")
            return
        }

        guard let buyer = players.first else {
            XCTFail("No buyer found")
            return
        }

        // buy train
        buyer.hand.add(train: train)

        XCTAssertTrue(buyer.hand.cards.count == 1)
        XCTAssertTrue(buyer.hand.cards.first?.production?.units == 1)
        XCTAssertTrue(buyer.hand.cards.first?.production?.unitsSpent == 0)

        guard let production = buyer.hand.cards.first?.production else {
            XCTFail("no production found")
            return
        }

        XCTAssertTrue(production.canSpend(unitsToSpend: 1))
        XCTAssertFalse(production.canSpend(unitsToSpend: 2))
        XCTAssertFalse(production.canSpend(unitsToSpend: 99))

        production.spend(unitsToSpend: 1)

        XCTAssertTrue(production.units == 0)
        XCTAssertTrue(production.unitsSpent == 1)

        production.reset()

        XCTAssertTrue(production.units == 1)
        XCTAssertTrue(production.unitsSpent == 0)
    }

    func testProductionIncreaseAndSpend() {
        let players = game.players

        guard let train = gameBoard.decks.first else {
            XCTFail("No train found")
            return
        }

        guard let buyer = players.first else {
            XCTFail("No buyer found")
            return
        }

        // buy train
        buyer.hand.add(train: train)

        XCTAssertTrue(buyer.hand.cards.count == 1)
        XCTAssertTrue(buyer.hand.cards.first?.production?.units == 1)
        XCTAssertTrue(buyer.hand.cards.first?.production?.unitsSpent == 0)

        guard let production = buyer.hand.cards.first?.production else {
            XCTFail("no production found")
            return
        }

        XCTAssertTrue(production.canSpend(unitsToSpend: 1))

        production.increase(by: 5)

        XCTAssertTrue(production.units == 6)
        XCTAssertTrue(production.canSpend(unitsToSpend: 6))

        production.spend(unitsToSpend: 3)

        XCTAssertTrue(production.units == 3)
        XCTAssertTrue(production.unitsSpent == 3)
        XCTAssertTrue(production.canSpend(unitsToSpend: 3))

        production.reset()

        XCTAssertTrue(production.units == 6)
        XCTAssertTrue(production.unitsSpent == 0)
        XCTAssertTrue(production.canSpend(unitsToSpend: 6))

    }




}

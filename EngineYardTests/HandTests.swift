//
//  PortfolioTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Tests involvingç adding cards to a player's hand

class HandTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAddToPortfolio()
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
            XCTFail("No train found")
            return
        }

        guard let firstPlayer = game.players.first else {
            XCTFail("No player found")
            return
        }

        guard let firstCard = firstTrain.cards.first else {
            XCTFail("no card found")
            return
        }


        XCTAssert(firstPlayer.hand.cards.count == 0)
        XCTAssertFalse(firstTrain.isOwned(by: firstPlayer))

        XCTAssertTrue( firstPlayer.hand.canAdd(card: firstCard) )

        firstPlayer.hand.add(card: firstCard)

        XCTAssert(firstPlayer.hand.cards.count == 1)

        guard let firstCardOwned = firstPlayer.hand.cards.first else {
            XCTFail("no first card owned found")
            return
        }

        XCTAssert(firstCardOwned.owner === firstPlayer)
        XCTAssert(firstCardOwned.production.units == 1)

        XCTAssertFalse( firstPlayer.hand.canAdd(card: firstCardOwned) )



    }


}

//
//  HandTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class HandTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testHand() {

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
        XCTAssertTrue(firstTrain.generation == .first && firstTrain.engineColor == .green)
        XCTAssertTrue(firstTrain.owners?.count == 0)

        let _ = players.map({
            XCTAssertTrue( $0.hand.cards.count == 0 )
        })

        // try to add all 4 cards from first train to 5 players; 
        // this should assign 4 players and leave 1 with no card

        for (index, player) in players.enumerated() {
            print ("#\(index)- Adding to player's hand \(player.name) -- \(player.hand.cards.count)")

            if (index < firstTrain.numberOfChildren) {
                XCTAssertTrue((player.hand.canAdd(train: firstTrain) != nil))
                let _ = player.hand.add(train: firstTrain)

                XCTAssertTrue(player.hand.cards.count == 1)

                let _ = player.hand.cards.map({
                    XCTAssertNotNil($0.owner)
                    XCTAssertTrue($0.parent == firstTrain)
                    XCTAssertNotNil($0.production)
                    XCTAssertTrue($0.production?.units == 1)
                })
            }
            else {
                XCTAssertFalse((player.hand.canAdd(train: firstTrain) != nil))
                XCTAssertTrue(player.hand.cards.count == 0)
            }
        }

        // remaining stock test
        
        let remainingStock = TrainAPI.getRemainingStock(train: firstTrain)
        XCTAssertTrue(remainingStock == 0, "\(remainingStock)")
        XCTAssertFalse(remainingStock < 0, "\(remainingStock)")

    }



}

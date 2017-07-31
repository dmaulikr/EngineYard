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


        /**
        for (index, p) in players.enumerated() {

            if (index < firstTrain.numberOfChildren) {

                let _ = p.hand.containsTrain(train: firstTrain)

                p.hand.add(train: firstTrain)

                XCTAssertTrue(p.hand.cards.count == 1)
                XCTAssertTrue(p.hand.cards.first?.parent == firstTrain)

            }
            else {

            }
        }

        let expectedOwners = firstTrain.owners?.count
        XCTAssertTrue( expectedOwners == 4, "\(expectedOwners)")
 **/
    }



}

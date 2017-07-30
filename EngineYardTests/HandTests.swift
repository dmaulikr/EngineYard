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

        for player in game.players {

            guard let firstUnownedCard = LocomotiveCardAPI.findFirstUnownedCard(for: firstTrain) else {
                return
            }

            /*
            guard let firstUnownedCard = firstTrain.cards.filter({ (card: LocomotiveCard) -> Bool in
                return (card.owner == nil)
            }).first else {
                break
            }
             */

            player.hand.add(card: firstUnownedCard)
        }

        let _ = firstTrain.cards.map({
            XCTAssertNotNil($0.owner)
        })


        for (index, p) in game.players.enumerated() {
            if (index < firstTrain.numberOfChildren) {
                XCTAssert(p.hand.cards.count == 1, "#\(index),  Cards: \(p.hand.cards.count)")
            }
            else {
                XCTAssert(p.hand.cards.count == 0)
            }
            print ("#\(index), Player: \(p.name), Cards: \(p.hand.cards)\n")
        }

    }



}

//
//  WalkThroughDeckTests.swift
//  EngineYard
//
//  Created by Amarjit on 04/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalkThroughDeckTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // test BidirectionalCollection extension
    func testNextDeck() {

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

        guard let lastTrain = gameBoard.decks.last else {
            XCTFail("no last train found")
            return
        }

        let afterFirst = gameBoard.decks.after(firstTrain)

        XCTAssertTrue(afterFirst?.generation == .first)
        XCTAssertTrue(afterFirst?.engineColor == .red)

        let afterLast = gameBoard.decks.after(lastTrain)
        XCTAssertNil(afterLast)
    }

    func testWalkThroughAllDecks() {

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

        var counter = 0
        for (_, element) in gameBoard.decks.enumerated() {

            let nextElement = gameBoard.decks.after(element)

            if (nextElement != nil) {
                let nextElementIndex = (gameBoard.decks.index(where: { (t: Train) -> Bool in
                    return (t == nextElement)
                }))

                if (nextElementIndex != nil) {
                    XCTAssertTrue(nextElement! == gameBoard.decks[nextElementIndex!])
                    counter += 1
                }
            }
        }

        XCTAssertTrue(counter == (gameBoard.decks.count - 1))
    }

}

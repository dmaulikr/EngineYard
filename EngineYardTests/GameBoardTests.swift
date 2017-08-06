//
//  GameBoardTests.swift
//  EngineYard
//
//  Created by Amarjit on 06/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard



class GameBoardTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPrepareBoard() {

        let expectedPlayers = Constants.NumberOfPlayers.max

        guard let generatedPlayers = Mock.players(howMany: expectedPlayers) else {
            XCTFail("No mock players generated")
            return
        }
        XCTAssert(generatedPlayers.count == expectedPlayers)

        guard let gameObj = Game.setup(players: generatedPlayers) else {
            XCTFail("** No game object defined **")
            return
        }
        guard let gameBoard = gameObj.gameBoard else {
            XCTFail("** No game board defined **")
            return
        }

        XCTAssertNotNil( gameObj.gameBoard )
        XCTAssertTrue(gameBoard.decks.count == Constants.Board.decks)

        // In a 5 player game, I expect 1 deck to be unlocked
        let unlocked = gameBoard.countUnlocked
        XCTAssert(unlocked == 1, "\(unlocked)")

        // Validate decks
        testValidateDecks(board: gameBoard)
    }

    func testValidateDecks(board: GameBoard)
    {

        // Validate board decks
        var cards = Mock.Cards()

        for train in board.decks
        {
            XCTAssert(train.cost % 4 == 0)
            XCTAssert(train.productionCost == Int(train.cost / 2))
            XCTAssert(train.income == Int(train.productionCost / 2))

            for _ in train.cards {
                switch train.engineColor {
                case .green:
                    cards.green += 1
                    break

                case .red:
                    cards.red += 1
                    break

                case .blue:
                    cards.blue += 1
                    break

                case .yellow:
                    cards.yellow += 1
                    break
                }
            }

        }

        XCTAssert(cards.green == Mock.Cards.Expected.green, "Not enough green cards. Found: \(cards.green), Expected: \(Mock.Cards.Expected.green)")
        XCTAssert(cards.red == Mock.Cards.Expected.red, "Not enough red cards. Found: \(cards.red), Expected: \(Mock.Cards.Expected.red)")
        XCTAssert(cards.yellow == Mock.Cards.Expected.yellow, "Not enough yellow cards. Found: \(cards.yellow), Expected: \(Mock.Cards.Expected.yellow)")
        XCTAssert(cards.blue == Mock.Cards.Expected.blue, "Not enough blue cards. Found: \(cards.blue), Expected: \(Mock.Cards.Expected.blue)")
        XCTAssert(cards.total == Mock.Cards.Expected.total, "Not enough cards, total = \(cards.total), Expected: \(Mock.Cards.Expected.total)")
    }

}

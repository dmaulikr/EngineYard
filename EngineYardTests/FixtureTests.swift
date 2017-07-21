//
//  FixtureTests.swift
//  EngineYard
//
//  Created by Amarjit on 21/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// Test in-game fixed locomotive data

fileprivate struct Cards {
    var green: Int = 0
    var red: Int = 0
    var blue: Int = 0
    var yellow: Int = 0
    var total : Int {
        return (self.green + self.red + self.blue + self.yellow)
    }

    fileprivate struct Expected {
        static let green = Constants.Board.numberOfCardsForColor(engineColor: .green)
        static let red = Constants.Board.numberOfCardsForColor(engineColor: .red)
        static let blue = Constants.Board.numberOfCardsForColor(engineColor: .blue)
        static let yellow = Constants.Board.numberOfCardsForColor(engineColor: .yellow)
        static let total = Constants.Board.cards
    }
}

// Total of these should equal totalCardsInGame (43)


class FixtureTests: BaseTests {

    var gameBoard: GameBoard!

    override func setUp() {
        super.setUp()

        self.gameBoard = GameBoard.prepare()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testFixtureData() {
        XCTAssert(gameBoard.decks.count == Constants.Board.decks)

        var cards = Cards()

        for train in gameBoard.decks {
            XCTAssert(train.cost % 4 == 0)
            XCTAssert(train.productionCost == Int(train.cost / 2))
            XCTAssert(train.income == Int(train.productionCost / 2))

            for _ in train.engines {
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

        XCTAssert(cards.green == Cards.Expected.green, "Not enough green cards. Found: \(cards.green), Expected: \(Cards.Expected.green)")
        XCTAssert(cards.red == Cards.Expected.red, "Not enough red cards. Found: \(cards.red), Expected: \(Cards.Expected.red)")
        XCTAssert(cards.yellow == Cards.Expected.yellow, "Not enough yellow cards. Found: \(cards.yellow), Expected: \(Cards.Expected.yellow)")
        XCTAssert(cards.blue == Cards.Expected.blue, "Not enough blue cards. Found: \(cards.blue), Expected: \(Cards.Expected.blue)")
        XCTAssert(cards.total == Cards.Expected.total, "Not enough cards, total = \(cards.total), Expected: \(Cards.Expected.total)")
    }

}

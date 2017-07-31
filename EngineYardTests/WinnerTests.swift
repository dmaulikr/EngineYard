//
//  WinnerTests.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WinnerTests: BaseTests {
    
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

    func testEndCashGoal() {
        let cash = [0,299,300,329,330,331]

        let filtered = cash.filter({
            return (Constants.hasReachedGoal(cash: $0))
        })

        XCTAssertTrue(filtered.count == 2)
    }

    func testWinnerIsDeclared() {
        let players = Mock.players(howMany: 5)!

        let filtered = players.filter({
            return (Constants.hasReachedGoal(cash: $0.wallet.balance))
        })

        XCTAssertTrue(filtered.count == 0)

        let _ = players.map({
            let value:Int = Int.randomInt(withMax: 50)
            let amount = (330 + value)
            $0.wallet.credit(amount: amount)
        })

        let _ = players.filter({
            return (Constants.hasReachedGoal(cash: $0.wallet.balance))
        })

        let sorted = PlayerAPI.sortPlayersByHighestCash(players: players)

        let filter2 = sorted.filter({
            return (Constants.hasReachedGoal(cash: $0.wallet.balance))
        })

        XCTAssertTrue(filter2.count > 0)

        guard let winner = filter2.first else {
            XCTFail("No winner found")
            return
        }
        print ("The winner is \(winner.description)")

    }
    

}

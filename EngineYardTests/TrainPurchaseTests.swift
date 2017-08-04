//
//  TrainPurchaseTests.swift
//  EngineYard
//
//  Created by Amarjit on 04/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TrainPurchaseTests: BaseTests {

    override func setUp() {
        super.setUp()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // I expect to be able to purchase a train, unlocks the next train, 
    // adds the train to a player's hand and debits the player's wallet
    func testPurchaseTrain() {


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

        guard let train = game.gameBoard?.decks.first else {
            XCTFail("No train found")
            return
        }

        guard let firstPlayer = game.players.first else {
            XCTFail("no player found")
            return
        }


        XCTAssertTrue(train.generation == .first && train.engineColor == .green)
        XCTAssertTrue(game.players.count == Constants.NumberOfPlayers.max)


        // Checks
        // 1. Train is unlocked, has orders
        // 2. There is stock available
        // 3. Player can afford train
        // 4. Player doesn't already have the train in his hand

        // I expect that all trains except first are invalid purchases

        var invalidPurchases: Int = 0
        let _ = game.gameBoard?.decks.map({

            do {
                let result = try $0.canBePurchased(by: firstPlayer)
                XCTAssertTrue(result)

            } catch let error {
                print (error)
                invalidPurchases += 1
            }
        })

        XCTAssertTrue(invalidPurchases == (Constants.Board.decks - 1))

        let countUnlockedBefore = gameBoard.countUnlocked
        XCTAssertTrue(countUnlockedBefore == 1)

        let cashBefore = firstPlayer.wallet.balance
        let expectedCashAfter = (cashBefore - train.cost)
        let expectedHandAfter = 1

        do {
            let result = try train.canBePurchased(by: firstPlayer)
            XCTAssertTrue(result)
            XCTAssertNotNil(firstPlayer.hand.canAdd(train: train))

            train.purchase(buyer: firstPlayer)

            XCTAssertTrue(firstPlayer.wallet.balance == expectedCashAfter)
            XCTAssertTrue(firstPlayer.hand.cards.count == expectedHandAfter)

            let countUnlockedAfter = gameBoard.countUnlocked
            XCTAssertTrue(countUnlockedAfter == 2, "\(countUnlockedAfter)")

        } catch let error {
            XCTFail(error as! String)
        }

    }

    // when all decks are unlocked, I expect no more trains to unlock
    func testPurchaseAll_ExpectedNilDecksToUnlock()
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

        XCTAssertTrue(gameBoard.countUnlocked == 1)

        for deck in gameBoard.decks {
            print ("at: \(deck.name), attempting to unlock next")
            TrainAPI.unlockNextDeck()
        }

        for deck in gameBoard.decks {
            XCTAssertTrue(deck.isUnlocked)
            XCTAssertTrue(deck.existingOrderValues.count > 0)
        }



    }


}

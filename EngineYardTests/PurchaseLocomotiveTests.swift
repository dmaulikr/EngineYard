//
//  PurchaseLocomotiveTests.swift
//  EngineYard
//
//  Created by Amarjit on 24/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class PurchaseLocomotiveTests: BaseTests {

    var gameObj: Game!
    var trains: [Locomotive]!

    override func setUp() {
        super.setUp()

        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: 5) else {
            XCTFail("No mock players found")
            return
        }

        guard let gameObj = Game.setup(players: mockPlayers) else {
            XCTFail("No game object")
            return
        }

        self.gameObj = gameObj
        self.trains = self.gameObj.gameBoard.decks
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPurchaseTrain() {

        var unlocked = trains.filter { (loco:Locomotive) -> Bool in
            return (loco.isUnlocked == true)
        }
        XCTAssert(unlocked.count == 1)

        guard let firstTrain = self.trains.first else {
            return
        }

        guard let firstPlayer = self.gameObj.players.first else {
            return
        }

        XCTAssertTrue(firstPlayer.account.canAfford(amount: firstTrain.cost))

        let beforePurchase = firstPlayer.account.balance
        firstTrain.purchase(buyer: firstPlayer)
        XCTAssert(firstPlayer.cash == (beforePurchase - firstTrain.cost))

        unlocked = trains.filter { (loco:Locomotive) -> Bool in
            return (loco.isUnlocked == true)
        }
        XCTAssert(unlocked.count == 2)

        XCTAssert(firstPlayer.engines.count == 1)
    }
}

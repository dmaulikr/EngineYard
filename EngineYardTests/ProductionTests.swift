//
//  ProductionTests.swift
//  EngineYard
//
//  Created by Amarjit on 24/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class ProductionTests: BaseTests {

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

    func testProduction() {

        guard let firstTrain = self.trains.first else {
            return
        }

        guard let firstPlayer = self.gameObj.players.first else {
            return
        }

        XCTAssert(firstPlayer.engines.count == 0, "\(firstPlayer.engines.count)")

        guard let firstEngine = firstTrain.engines.first else {
            return
        }

        LocomotiveAPI.purchase(train: firstTrain, player: firstPlayer)

        XCTAssert(firstEngine.production.units == 1)
        XCTAssert(firstEngine.owner == firstPlayer)
        XCTAssert(firstEngine.parent == firstTrain)
        XCTAssert(firstPlayer.engines.count == 1, "\(firstPlayer.engines.count)")
        XCTAssert(firstTrain.owners?.count == 1)
        XCTAssert(firstTrain.owners?.first == firstPlayer)

        XCTAssertTrue( firstEngine.production.canSpend(unitsToSpend: 1) )
        XCTAssert(firstEngine.production.units == 1)
        XCTAssertFalse(firstEngine.production.canSpend(unitsToSpend: 2))

        firstEngine.production.increase(by: 5)
        XCTAssert(firstEngine.production.units == 6)
        XCTAssertTrue(firstEngine.production.canSpend(unitsToSpend: 6))

        firstEngine.production.spend(unitsToSpend: 3)
        XCTAssert(firstEngine.production.units == 3)
        XCTAssert(firstEngine.production.unitsSpent == 3)

        firstEngine.production.reset()

        XCTAssert(firstEngine.production.units == 6)
        let spent = firstEngine.production.unitsSpent
        XCTAssert(spent == 0, "\(spent)")
    }

}

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

        //LocomotiveAPI.purchase(train: firstTrain, player: firstPlayer)
        firstTrain.purchase(buyer: firstPlayer)

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

    func testShiftProduction() {

        // Player has a portfolio of 3 trains [t1,t2,t3]
        // Player should be able to shift production from t1 to [t2,t3]

        guard let firstPlayer = self.gameObj.players.first else {
            return
        }

        // force the player to have $50 so they can afford all the trains in cart
        let difference = (50 - firstPlayer.cash)
        firstPlayer.account.credit(amount: difference)
        let seedCash = firstPlayer.account.balance
        XCTAssert(seedCash == 50)

        let cart = [trains[0], trains[1], trains[2]]
        let totalAmount = cart.reduce(0) { $0 + ($1.cost ) }

        XCTAssertTrue(firstPlayer.account.canAfford(amount: totalAmount))

        guard let fEngine = trains.first?.engines.first else {
            return
        }

        XCTAssertNil(fEngine.production.shiftable())

        for train in cart {
            train.purchase(buyer: firstPlayer)
        }

        XCTAssert(firstPlayer.engines.count == 3)
        XCTAssert(trains[0].owners?.count == 1)
        XCTAssert(trains[1].owners?.count == 1)
        XCTAssert(trains[2].owners?.count == 1)

        XCTAssert(firstPlayer.account.balance == (seedCash - totalAmount))

        let _ = firstPlayer.engines.map({
            XCTAssert($0.production.units == 1)
        })

        guard let firstEngine = firstPlayer.engines.first else {
            return
        }

        guard let portfolio = firstEngine.production.shiftable() else {
            XCTFail("Portfolio is empty")
            return
        }

        XCTAssert(portfolio.count > 0)
        XCTAssert(portfolio.count == 2)
        XCTAssert(portfolio[0].parent?.engineColor == .red)
        XCTAssert(portfolio[1].parent?.engineColor == .yellow)

    }


}

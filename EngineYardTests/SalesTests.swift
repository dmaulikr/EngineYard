//
//  SalesTests.swift
//  EngineYard
//
//  Created by Amarjit on 24/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class SalesTests: BaseTests {

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
        super.tearDown()
    }

    func testSalesRuleLower() {
        let orders = [3,5,2]
        let units = 1

        let matcher = SalesMatchHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.matchCase == .lower)
    }

    func testSalesRulePerfectMatch() {
        let orders = [3,5,2]
        let units = 3

        let matcher = SalesMatchHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.matchCase == .perfectMatch)
    }

    func testSalesRuleHigher() {
        let orders = [3,5,2]
        let units = 6

        let matcher = SalesMatchHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.matchCase == .higher)
    }

    func testSalesMatchHandlerHigher() {
        var orders = [3,5,2]
        var units = 6

        while ((units > 0) && (orders.count > 0)) {
            let matcher = SalesMatchHandler.init(orders: orders, units: units)

            print("selling units: \(units), \(orders)\n")

            switch matcher.matchCase {
            case .perfectMatch:
                orders[matcher.matchTuple.0] -= matcher.matchTuple.1
                units -= units

                XCTAssertTrue(orders[matcher.matchTuple.0] == 0)
                XCTAssertTrue(units == 0)
                break
            case .lower:
                orders[matcher.matchTuple.0] -= units
                units -= units
                break
            case .higher:
                let remainingUnits = (matcher.matchTuple.1 - units)
                units -= matcher.matchTuple.1
                orders[matcher.matchTuple.0] = remainingUnits

                XCTAssertTrue(units == 1)
                XCTAssertTrue(orders[matcher.matchTuple.0] == remainingUnits)
                break
            }

            print("remaining units: \(units), \(orders)\n")
        }


    }
}

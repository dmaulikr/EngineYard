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

        let matcher = SalesMatchHandler.init(orders: orders, goods: units)
        XCTAssertTrue(matcher.matchCase == .lower)
    }

    func testSalesRulePerfectMatch() {
        let orders = [3,5,2]
        let units = 3

        let matcher = SalesMatchHandler.init(orders: orders, goods: units)
        XCTAssertTrue(matcher.matchCase == .perfectMatch)
    }

    func testSalesRuleHigher() {
        let orders = [3,5,2]
        let units = 6

        let matcher = SalesMatchHandler.init(orders: orders, goods: units)
        XCTAssertTrue(matcher.matchCase == .higher)
    }

    func testSalesManipulator() {

    }
}

//
//  SalesRuleTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard


class SalesRuleTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSalesRuleLower() {
        let orders = [3,5,2]
        let units = 1

        let matcher = SalesRuleHandler.init(orders: orders, units: units)

        XCTAssertTrue(matcher.ruleType == .lower)
    }

    func testSalesRulePerfectMatch() {
        let orders = [3,5,2]
        let units = 3

        let matcher = SalesRuleHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.ruleType == .perfect)
    }

    func testSalesRuleHigher() {
        let orders = [3,5,2]
        let units = 6

        let matcher = SalesRuleHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.ruleType == .higher)
    }

    func testCardSales() {

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

        guard let firstDeck = gameBoard.decks.first else {
            return
        }

        guard let firstPlayer = game.players.first else {
            return
        }

        firstDeck.purchase(buyer: firstPlayer)

        XCTAssert(firstPlayer.hand.cards.count == 1)

        guard let firstCard = firstPlayer.hand.cards.first else {
            XCTFail("no first card found")
            return
        }

        XCTAssertTrue(firstCard.production?.units == 1)
        XCTAssertTrue(firstDeck.orderBook.existingOrders.count > 0)

        let orders = firstDeck.existingOrderValues
        guard let units = firstCard.production?.units else {
            XCTFail("no units found")
            return
        }

        let ruleHandler = SalesRuleHandler.init(orders: orders, units: units)

        guard let tmpProduction = firstCard.production else {
            return
        }
        guard let tmpParent = firstCard.parent else {
            return
        }

        print ("Selling: \(tmpProduction.units) units from \(tmpParent.name)")
        print (ruleHandler)





    }
}

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

        let matcher = SalesRuleHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.ruleType == .lower)
    }

    func testSalesRulePerfectMatch() {
        let orders = [3,5,2]
        let units = 3

        let matcher = SalesRuleHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.ruleType == .perfectMatch)
    }

    func testSalesRuleHigher() {
        let orders = [3,5,2]
        let units = 6

        let matcher = SalesRuleHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.ruleType == .higher)
    }

    func testSalesLower() {
        var orders = [3,3,3]
        var units = 1

        let matcher = SalesRuleHandler.init(orders: orders, units: units)
        print("selling units: \(units), \(orders)\n")

        XCTAssert(matcher.ruleType == .lower)

        switch matcher.ruleType {
        case .perfectMatch:
            break
        case .lower:
            orders[matcher.matchTuple.0] -= units
            units -= units
            break
        case .higher:
            break
        }

        let filtered = orders.filter { $0 != 0 }
        orders = filtered

        XCTAssert(units == 0)
    }

    func testSalesPerfect() {
        var orders = [3,3,3]
        var units = 3

        let matcher = SalesRuleHandler.init(orders: orders, units: units)
        print("selling units: \(units), \(orders)\n")

        XCTAssert(matcher.ruleType == .perfectMatch)

        switch matcher.ruleType {
        case .perfectMatch:
            orders[matcher.matchTuple.0] -= matcher.matchTuple.1
            units -= units
            break
        case .lower:
            break
        case .higher:
            break
        }

        let filtered = orders.filter { $0 != 0 }
        orders = filtered
        
        XCTAssert(units == 0)
    }

    func testSalesHigher() {
        var orders = [3,4,5]
        var units = 6

        let matcher = SalesRuleHandler.init(orders: orders, units: units)
        print("selling units: \(units), \(orders)\n")

        XCTAssert(matcher.ruleType == .higher)

        switch matcher.ruleType {
        case .perfectMatch:
            break
        case .lower:
            break
        case .higher:
            units -= matcher.matchTuple.1
            orders[matcher.matchTuple.0] -= orders[matcher.matchTuple.0]

            XCTAssert(units == 1)
            XCTAssert(orders[matcher.matchTuple.0] == 0)
            break
        }

        let filtered = orders.filter { $0 != 0 }
        orders = filtered
    }



    func testSalesMatchLoop() {
        var orders = [3,5,2]
        var units = 10
        let perUnitPrice = 1
        let journal: SalesJournal = SalesJournal.init()

        while ((units > 0) && (orders.count > 0)) {
            let matcher = SalesRuleHandler.init(orders: orders, units: units)

            print("selling units: \(units), \(orders)\n")

            switch matcher.ruleType {
            case .perfectMatch:

                let entry = SalesLedger.init(unitsSold: units, perUnitPrice: perUnitPrice)
                journal.entries.append(entry)

                orders[matcher.matchTuple.0] -= matcher.matchTuple.1
                units -= units
                break
            case .lower:
                let entry = SalesLedger.init(unitsSold: units, perUnitPrice: perUnitPrice)
                journal.entries.append(entry)

                orders[matcher.matchTuple.0] -= units
                units -= units
                break
            case .higher:
                let entry = SalesLedger.init(unitsSold: matcher.matchTuple.1, perUnitPrice: perUnitPrice)
                journal.entries.append(entry)

                let remainingUnits = (units - matcher.matchTuple.1) // 6-5
                units -= remainingUnits
                orders[matcher.matchTuple.0] -= orders[matcher.matchTuple.0]
                break
            }

            let filtered = orders.filter { $0 != 0 }
            orders = filtered

            print("remaining units: \(units), \(orders)\n")
        }

        XCTAssertTrue(units == 2, "\(units)")
        XCTAssert(journal.total == 10)
    }
}

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

    func testPlayerSales() {

        // force first train to have max capacity of orders
        guard let firstTrain = trains.first else {
            return
        }
        XCTAssert(firstTrain.orderBook.existingOrders.count == 1)
        let remainingSpace = (firstTrain.capacity - firstTrain.orderBook.existingOrders.count)
        XCTAssert(remainingSpace == 2)
        firstTrain.orderBook.generateExistingOrders(howMany: remainingSpace)
        XCTAssert(firstTrain.orderBook.existingOrders.count == firstTrain.capacity)

        // force first 3 players to buy the first train in order
        for (index, p) in gameObj.players.enumerated() {
            if (index < 3) {
                if (p.account.canAfford(amount: firstTrain.cost)) {
                    firstTrain.purchase(buyer: p)
                }
            }
            else {
                break
            }
        }

        let countUnlocked = gameObj.gameBoard.decks.filter { (loco: Locomotive) -> Bool in
            return (loco.isUnlocked)
        }.count

        let trainsWithOrders = gameObj.gameBoard.decks.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
            }.sorted { (loco1: Locomotive, loco2: Locomotive) -> Bool in
            return (loco1.cost < loco2.cost)
        }

        XCTAssert(countUnlocked == 2)
        XCTAssert(trainsWithOrders.count == 2)
        XCTAssert(firstTrain.owners?.count == 3)

        // Sell production from trainsWithOrders
        /*
        for train in trainsWithOrders {
            print ("Selling production from \(train.name)")

            // sort engines by turn order
            let sortedEngines = train.engines.filter({ (eng: Engine) -> Bool in
                return ((eng.owner != nil) && (eng.production.units > 0))
            }).sorted(by: { (eng1:Engine, eng2:Engine) -> Bool in
                return ((eng1.owner?.turnOrder)! < (eng2.owner?.turnOrder)!)
            })

            //while train.orderBook.existingOrders.count > 0 {
                for engine in sortedEngines {

                    let units = engine.production.units
                    let orders = train.orderBook.existingOrders

                    while ((units > 0) && (orders.count > 0)) {
                        //let matcher = SalesRuleHandler.init(orders: orders, units: units)
                        print("selling units: \(units), \(orders)\n")
                        
                    }
                }

            //}
        }
 */

    }



}

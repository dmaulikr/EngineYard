//
//  SalesHandlerTests.swift
//  EngineYard
//
//  Created by Amarjit on 07/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

fileprivate struct Actor {
    var units: Int

    init(units: Int) {
        self.units = units
    }
}

class SalesHandlerTests: BaseTests {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSalesLowerHandling()
    {
        var orders = [6]
        var units = 1

        var matcher = SalesRuleHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.ruleType == .lower)

        matcher.handle()

        orders = matcher.orders
        units = matcher.units

        XCTAssertTrue(orders.first == 5)
        XCTAssertTrue(units == 0)
    }

    func testSalesPerfectHandling()
    {
        var orders = [6]
        var units = 6

        var matcher = SalesRuleHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.ruleType == .perfect)

        matcher.handle()

        orders = matcher.orders
        units = matcher.units

        XCTAssertTrue(orders.first == 0)
        XCTAssertTrue(units == 0)
    }

    func testSalesHigherHandling()
    {
        var orders = [3]
        var units = 6

        var matcher = SalesRuleHandler.init(orders: orders, units: units)
        XCTAssertTrue(matcher.ruleType == .higher)

        matcher.handle()

        orders = matcher.orders
        units = matcher.units

        XCTAssertTrue(orders.first == 0)
        XCTAssertTrue(units == 3)
    }

    
}

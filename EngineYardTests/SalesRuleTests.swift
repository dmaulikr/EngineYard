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

}

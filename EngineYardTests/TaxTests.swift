//
//  TaxTests.swift
//  EngineYard
//
//  Created by Amarjit on 21/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TaxTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTaxDue() {
        var cash = 100
        let tax = Tax.init(balance: cash)
        let taxDue = Int(tax.calculate())
        XCTAssert(taxDue == 10)
        cash = tax.pay()
        XCTAssert(cash == 90)
    }

    func testAddTax() {
        var cash = 300
        let tax = Tax.init(balance: cash)
        cash = Int(tax.addSalesTax())
        XCTAssert(cash == 330)
    }

    func testPlayersPayTax() {
        guard var mockPlayers = PlayerAPI.generateMockPlayers(howMany: 5) else {
            XCTFail("No mock players found")
            return
        }

        let seedCash = Constants.SeedCash.fivePlayers
        _ = mockPlayers.map({
            $0.account.credit(amount: seedCash)
        })

        let taxObj = Tax.init(balance: seedCash)

        // Pay tax
        mockPlayers = Tax.applyTax(players: mockPlayers)

        let expectedValue = (seedCash - Int(taxObj.calculate()))

        _ = mockPlayers.map({
            XCTAssert( $0.account.balance == expectedValue )
        })
    }
}

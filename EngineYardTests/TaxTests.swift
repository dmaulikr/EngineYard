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

        let taxDue = Tax.calculate(onBalance: cash)
        XCTAssert(taxDue == 10)
        cash = Tax.pay(onBalance: cash)
        XCTAssert(cash == 90)

    }

    func testAddTax() {
        var cash = 300
        cash = Tax.addSalesTax(toBalance: cash)
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


        // Pay tax
        mockPlayers = Tax.applyTax(players: mockPlayers)

        _ = mockPlayers.map({

            let taxDue = Tax.calculate(onBalance: $0.account.balance)
            let expectedValue = (seedCash - taxDue)

            XCTAssert( $0.account.balance == expectedValue )
        })

    }
}

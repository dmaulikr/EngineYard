//
//  TaxTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
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
        let balance = 300
        let newBalance = Tax.pay(onBalance: balance)
        let taxDue = Tax.calculateTaxDue(onBalance: balance)
        XCTAssert(newBalance == (balance - taxDue))
    }

    func testSalesTax() {
        let balance = 300
        let expected = 330
        let newBalance = Tax.addSalesTax(toBalance: balance)
        XCTAssert(newBalance == expected)
    }

    func testTaxOnWallet() {
        // simulate 5 players wallets
        var wallets: [Wallet] = [Wallet]()
        for _ in 1...5 {
            let wallet = Wallet.init(balance: 100)
            wallets.append(wallet)
        }

        let _ = wallets.map({$0.debit(amount: Tax.calculateTaxDue(onBalance: $0.balance))})

        let _ = wallets.map({
            XCTAssert($0.balance == 90)
        })
    }

}

//
//  WalletTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class WalletTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testWalletCanDebit() {
        var wallet = Wallet.init(balance: 100)
        XCTAssertTrue(wallet.canDebit(amount: 100))
        XCTAssertFalse(wallet.canDebit(amount: 101))
        XCTAssertFalse(wallet.canDebit(amount: -99))
        XCTAssertFalse(wallet.canDebit(amount: -101))

        wallet.credit(amount: 100)
        XCTAssert(wallet.balance == 200)
    }

    func testWalletCanCredit() {
        var wallet = Wallet.init(balance: 100)
        XCTAssertTrue(wallet.canCredit(amount: 99))
        XCTAssertFalse(wallet.canCredit(amount: -100))
        XCTAssertFalse(wallet.canCredit(amount: -1))

        wallet.debit(amount: 100)
        XCTAssert(wallet.balance == 0)
    }

}

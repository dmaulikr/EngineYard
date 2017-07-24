//
//  AccountTests.swift
//  EngineYard
//
//  Created by Amarjit on 21/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class AccountTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAccount() {
        let player = Player.init(name: "Bob", asset: nil)
        player.account.credit(amount: 100)
        XCTAssert(player.cash == 100)
        XCTAssert(player.account.balance == player.cash)

        XCTAssertTrue(player.account.canAfford(amount: 10))
        XCTAssertFalse(player.account.canAfford(amount: 101))

        player.account.debit(amount: 99)
        XCTAssert(player.cash == 1)
    }


}

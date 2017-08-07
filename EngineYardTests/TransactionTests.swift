//
//  TransactionTests.swift
//  EngineYard
//
//  Created by Amarjit on 07/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TransactionTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testTransaction()
    {
        let transactions = [
            Transaction.init(amount: 100),
            Transaction.init(amount: 200),
            Transaction.init(amount: 300)
        ]

        XCTAssertTrue(transactions.count == 3)
    }
}

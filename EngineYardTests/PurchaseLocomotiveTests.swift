//
//  PurchaseLocomotiveTests.swift
//  EngineYard
//
//  Created by Amarjit on 24/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class PurchaseLocomotiveTests: BaseTests {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
//
//    func testPurchaseTrain() {
//
//        var unlocked = trains.filter { (loco:Locomotive) -> Bool in
//            return (loco.isUnlocked == true)
//        }
//        XCTAssert(unlocked.count == 1)
//
//        guard let firstTrain = self.trains.first else {
//            return
//        }
//
//        guard let firstPlayer = self.gameObj.players.first else {
//            return
//        }
//
//        XCTAssertTrue(firstPlayer.account.canAfford(amount: firstTrain.cost))
//
//        let beforePurchase = firstPlayer.account.balance
//        firstTrain.purchase(buyer: firstPlayer)
//        XCTAssert(firstPlayer.cash == (beforePurchase - firstTrain.cost))
//
//        unlocked = trains.filter { (loco:Locomotive) -> Bool in
//            return (loco.isUnlocked == true)
//        }
//        XCTAssert(unlocked.count == 2)
//
//        XCTAssert(firstPlayer.engines.count == 1)
//    }
}

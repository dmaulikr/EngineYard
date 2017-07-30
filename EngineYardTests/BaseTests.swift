//
//  BaseTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class BaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGameObject() {
        let gameObj: Game = Game.init()
        XCTAssertFalse(gameObj.inProgress)
        XCTAssertNil(gameObj.gameBoard)
    }

    func testTrainEnums() {
        let allGenerations = Generation.allValues
        XCTAssert(allGenerations.count == 5)
        let allColors = EngineColor.allValues
        XCTAssert(allColors.count == 4)
    }

    
}

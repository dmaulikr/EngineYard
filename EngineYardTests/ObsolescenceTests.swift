//
//  ObsolescenceTests.swift
//  EngineYard
//
//  Created by Amarjit on 21/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class ObsolescenceTests: BaseTests {

    var gameObj: Game!
    
    override func setUp() {
        super.setUp()

        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: 5) else {
            XCTFail("No mock players found")
            return
        }

        guard let gameObj = Game.setup(players: mockPlayers) else {
            XCTFail("No game object")
            return
        }

        self.gameObj = gameObj
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    // Note - This is testing with 5 player game
    func testNoChange() {
        let trains = self.gameObj.gameBoard.decks
        let ob = Obsolescence.init(trains: trains)

        for (index,engineColorRef) in EngineColor.allValues.enumerated()
        {
            guard let result = ob.filterTrainsOnColorWithOrders(engineColor: engineColorRef) else {
                return
            }
            if (index == 0) {
                XCTAssert(result.count == 1)
            }
            else {
                XCTAssert(result.count == 0)
            }
        }

    }
       
}

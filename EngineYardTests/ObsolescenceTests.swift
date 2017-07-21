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
            guard let result = ob.findGenerationsForEngineColor(engineColor: engineColorRef) else {
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

    // mock the deck so that it will have 1 generation valid
    func testOneGeneration() {
        let trains = self.gameObj.gameBoard.decks

        // force unlock first train
        guard let firstTrain = trains.first else {
            XCTFail("No train found")
            return
        }

        XCTAssert(firstTrain.orderBook.existingOrders.count == 1)

        let countTrainsWithOrders = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
        }.count

        XCTAssert(countTrainsWithOrders == 1)

        let ob = Obsolescence.init(trains: trains)
        ob.handler()

        XCTAssert(firstTrain.orderBook.existingOrders.count == 2, "\(firstTrain.orderBook.existingOrders.count)")
        XCTAssert(firstTrain.orderBook.completedOrders.count == 0)

        print ("firstTrain.orders = \(firstTrain.orderBook.existingOrders)")
    }

    // mock the deck so that it will have 2 generations valid
    func testTwoGenerations() {
        let trains = self.gameObj.gameBoard.decks

        // force unlock trains
        for index in 0...4 {
            if (trains[index].orderBook.existingOrders.count == 0) {
                trains[index].orderBook.generateExistingOrders(howMany: 1)
            }
        }
    }

    // mock the deck so that it will have 3 generations valid
    func testThreeGenerations() {

    }
       
}

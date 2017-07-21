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
    var trains: [Locomotive]!

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
        self.trains = self.gameObj.gameBoard.decks
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testUnlockAll() {

        // force unlock all trains
        for (_, train) in trains.enumerated() {
            if (train.orderBook.existingOrders.count == 0) {
                train.orderBook.generateExistingOrders(howMany: 1)
            }
        }

        let trainsWithOrders = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
            }

        XCTAssert(trainsWithOrders.count == Constants.Board.decks)

        // test generations
        let greenGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .green)
        XCTAssert(greenGenerations?.count == Constants.Board.numberOfDecksForColor(color: .green))

        let redGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .red)
        XCTAssert(redGenerations?.count == Constants.Board.numberOfDecksForColor(color: .red))

        let blueGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .blue)
        XCTAssert(blueGenerations?.count == Constants.Board.numberOfDecksForColor(color: .blue))

        let yellowGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .yellow)
        XCTAssert(yellowGenerations?.count == Constants.Board.numberOfDecksForColor(color: .yellow))
    }

    // Note - This is testing with 5 player game
    func testNoChange() {

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

        // force unlock first train
        guard let firstTrain = trains.first else {
            XCTFail("No train found")
            return
        }

        XCTAssert(firstTrain.orderBook.existingOrders.count == 1)

        let trainsWithOrders = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
        }

        XCTAssert(trainsWithOrders.count == 1)

        let ob = Obsolescence.init(trains: trainsWithOrders)
        ob.handler()

        XCTAssert(firstTrain.orderBook.existingOrders.count == 2, "\(firstTrain.orderBook.existingOrders.count)")
        XCTAssert(firstTrain.orderBook.completedOrders.count == 0)

        print ("firstTrain.orders = \(firstTrain.orderBook.existingOrders)")
    }

    // mock the deck so that it will have 2 green generations valid
    func testTwoGenerations() {

        // force unlock trains
        for index in 0...4 {
            if (trains[index].orderBook.existingOrders.count == 0) {
                trains[index].orderBook.generateExistingOrders(howMany: 1)
            }
        }

        let trainsWithOrders = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
            }

        XCTAssert(trainsWithOrders.count == 5)

        // Transfer all orders to completed orders
        for train in trainsWithOrders {
            for (index, _) in train.orderBook.existingOrders.enumerated() {
                train.orderBook.transfer(index: index, destination: .completedOrder)
            }
        }

        let countExisting = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
        }.count

        let countCompleted = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.completedOrders.count > 0)
        }.count

        XCTAssert(countExisting == 0)
        XCTAssert(countCompleted == 5)

        // test generations 
        guard let greenGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .green) else {
            return
        }

        guard let firstGreenTrain = greenGenerations.first else {
            return
        }
        guard let lastGreenTrain = greenGenerations.last else {
            return
        }

        XCTAssert(firstGreenTrain.orderBook.completedOrders.count == 1)

        XCTAssert(greenGenerations.count == 2)

        guard let redGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .red) else {
            return
        }
        XCTAssert(redGenerations.count == 1)

        guard let blueGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .blue) else {
            return
        }
        XCTAssert(blueGenerations.count == 1)

        guard let yellowGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .yellow) else {
            return
        }
        XCTAssert(yellowGenerations.count == 1)

        let ob = Obsolescence.init(trains: trainsWithOrders)
        ob.handler()

        // 1st train
        XCTAssert(firstGreenTrain.engineColor == .green)
        XCTAssert(firstGreenTrain.generation == .first)
        XCTAssert(firstGreenTrain.orderBook.existingOrders.count == 0, "\(firstGreenTrain.orderBook.existingOrders.count)")
        XCTAssertTrue(firstGreenTrain.isRusting)

        // 2nd train
        XCTAssert(lastGreenTrain.engineColor == .green)
        XCTAssert(lastGreenTrain.generation == .second)
        XCTAssert(lastGreenTrain.orderBook.existingOrders.count == 2)

        let countRusting = trains.filter({ (loco: Locomotive) -> Bool in
            return (loco.isRusting)
        }).count

        let countHasRusted = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.hasRusted)
        }.count

        XCTAssert(countRusting == 1)
        XCTAssert(countHasRusted == 0)
    }

    // mock the deck so that it will have 3 generations valid
    func testThreeGenerations() {

        // force unlock trains
        for index in 0...7 {
            if (trains[index].orderBook.existingOrders.count == 0) {
                trains[index].orderBook.generateExistingOrders(howMany: 1)
            }
        }

        let trainsWithOrders = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
        }

        XCTAssert(trainsWithOrders.last?.engineColor == .green)

        XCTAssert(trainsWithOrders.count == 8)

        // Transfer all to completed orders
        for train in trainsWithOrders {
            for (index, _) in train.orderBook.existingOrders.enumerated() {
                train.orderBook.transfer(index: index, destination: .completedOrder)
            }
        }
        let countExisting = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
            }.count

        let countCompleted = trains.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.completedOrders.count > 0)
            }.count

        XCTAssert(countExisting == 0)
        XCTAssert(countCompleted == 8)


        // test generations
        guard let greenGenerations = Obsolescence(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .green) else {
            return
        }

        XCTAssert(greenGenerations.count == 3)

        for (index, train) in trainsWithOrders.enumerated() {
            print ("#\(index), \(train.name), orders: \(train.existingOrders), completedOrders: \(train.completedOrders), rusting: \(train.isRusting), hasRusted: \(train.hasRusted)")
        }

        // start obsolescence of 3 generations
        let ob = Obsolescence.init(trains: trainsWithOrders)
        ob.handler()
        
        for (index, train) in trainsWithOrders.enumerated() {
            print ("#\(index), \(train.name), orders: \(train.existingOrders), completedOrders: \(train.completedOrders), rusting: \(train.isRusting), hasRusted: \(train.hasRusted)")
        }
    }
       
}

//
//  ObsolescenceTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

// NEEDS REFACTORING

class ObsolescenceTests: BaseTests {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    /**
    var gameObj: Game!
    var gameBoard: GameBoard = GameBoard.init()
    var trains: [Train] = [Train]()

    override func setUp() {
        super.setUp()

        guard let gameObj = Game.setup(players: Mock.players(howMany: 5)!) else {
            XCTFail("No game object")
            return
        }
        guard let gameBoard = gameObj.gameBoard else {
            XCTFail("No game board defined")
            return
        }

        self.gameObj = gameObj
        self.gameBoard = gameBoard
        self.trains = gameBoard.decks
    }

    override func tearDown() {
        super.tearDown()
    }

    func testUnlockAll() {

        // force unlock all trains
        for (_, train) in trains.enumerated() {
            if (train.orderBook.existingOrders.count == 0) {
                train.orderBook.generateExistingOrders(howMany: 1)
            }
        }

        let trainsWithOrders = trains.filter { (t: Train) -> Bool in
            return (t.orderBook.existingOrders.count > 0)
        }

        XCTAssert(trainsWithOrders.count == Constants.Board.decks)

        // test generations
        let greenGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .green)
        XCTAssert(greenGenerations?.count == Constants.Board.numberOfDecksForColor(color: .green))

        let redGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .red)
        XCTAssert(redGenerations?.count == Constants.Board.numberOfDecksForColor(color: .red))

        let blueGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .blue)
        XCTAssert(blueGenerations?.count == Constants.Board.numberOfDecksForColor(color: .blue))

        let yellowGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .yellow)
        XCTAssert(yellowGenerations?.count == Constants.Board.numberOfDecksForColor(color: .yellow))
    }

    // Note - This is testing with 5 player game
    func testNoChange() {

        let ob = ObsolescenceManager.init(trains: trains)

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

        let trainsWithOrders = trains.filter { (t: Train) -> Bool in
            return (t.orderBook.existingOrders.count > 0)
        }

        XCTAssert(trainsWithOrders.count == 1)

        let ob = ObsolescenceManager.init(trains: trainsWithOrders)
        ob.handler()

        print (trainsWithOrders.description)

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

        let trainsWithOrders = trains.filter { (t: Train) -> Bool in
            return (t.orderBook.existingOrders.count > 0)
        }

        XCTAssert(trainsWithOrders.count == 5)

        // Transfer all orders to completed orders
        for train in trainsWithOrders {
            for (index, item) in train.orderBook.existingOrders.enumerated() {
                train.orderBook.transferOrder(order: item, index: index)
            }
        }

        let countExisting = trains.filter { (t: Train) -> Bool in
            return (t.orderBook.existingOrders.count > 0)
            }.count

        let countCompleted = trains.filter { (t: Train) -> Bool in
            return (t.orderBook.completedOrders.count > 0)
            }.count

        XCTAssert(countExisting == 0)
        XCTAssert(countCompleted == 5)

        // test generations
        guard let greenGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .green) else {
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

        guard let redGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .red) else {
            return
        }
        XCTAssert(redGenerations.count == 1)

        guard let blueGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .blue) else {
            return
        }
        XCTAssert(blueGenerations.count == 1)

        guard let yellowGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .yellow) else {
            return
        }
        XCTAssert(yellowGenerations.count == 1)

        let ob = ObsolescenceManager.init(trains: trainsWithOrders)
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

        let countRusting = trains.filter({ (t: Train) -> Bool in
            return (t.isRusting)
        }).count

        let countHasRusted = trains.filter { (t: Train) -> Bool in
            return (t.hasRusted)
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

        let trainsWithOrders = trains.filter { (t: Train) -> Bool in
            return (t.orderBook.existingOrders.count > 0)
        }

        XCTAssert(trainsWithOrders.last?.engineColor == .green)
        XCTAssert(trainsWithOrders.count == 8)

        // Transfer all to completed orders
        for train in trainsWithOrders {
            for (index, item) in train.orderBook.existingOrders.enumerated() {
                train.orderBook.transferOrder(order: item, index: index)
            }
        }
        let countExisting = trains.filter { (t: Train) -> Bool in
            return (t.orderBook.existingOrders.count > 0)
            }.count

        let countCompleted = trains.filter { (t: Train) -> Bool in
            return (t.orderBook.completedOrders.count > 0)
            }.count

        XCTAssert(countExisting == 0)
        XCTAssert(countCompleted == 8)


        // test generations
        guard let greenGenerations = ObsolescenceManager(trains: trainsWithOrders).findGenerationsForEngineColor(engineColor: .green) else {
            return
        }

        XCTAssert(greenGenerations.count == 3)

        for (index, train) in trainsWithOrders.enumerated() {
            print ("#\(index), \(train.name), orders: \(train.existingOrderValues), completedOrders: \(train.completedOrderValues), rusting: \(train.isRusting), hasRusted: \(train.hasRusted)")
        }

        // start obsolescence of 3 generations
        let ob = ObsolescenceManager.init(trains: trainsWithOrders)
        ob.handler()

        for (index, train) in trainsWithOrders.enumerated() {
            print ("#\(index), \(train.name), orders: \(train.existingOrderValues), completedOrders: \(train.completedOrderValues), rusting: \(train.isRusting), hasRusted: \(train.hasRusted)")
        }

        let isRusting = trainsWithOrders.filter { (t: Train) -> Bool in
            return (t.isRusting)
        }
        
        let hasRusted = trainsWithOrders.filter { (t: Train) -> Bool in
            return (t.hasRusted)
        }
        
        XCTAssert(isRusting.count == 2)
        XCTAssert(hasRusted.count == 1)
        
        guard let firstRusted = hasRusted.first else {
            return
        }
        
        XCTAssert(firstRusted.engineColor == .green)
        XCTAssert(firstRusted.generation == .first)
    }**/
    
}

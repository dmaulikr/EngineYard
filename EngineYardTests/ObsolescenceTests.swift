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
    var gameBoard: GameBoard = GameBoard.init()
    var locos: [Locomotive] = [Locomotive]()

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
        guard let gameBoard = gameObj.gameBoard else {
            XCTFail("No game board defined")
            return
        }

        self.gameObj = gameObj
        self.gameBoard = gameBoard
        self.locos = gameBoard.decks
    }

    override func tearDown() {
        super.tearDown()
    }

    func testUnlockAll() {

        // force unlock all loco
        for (_, loco) in locos.enumerated() {
            if (loco.orderBook.existingOrders.count == 0) {
                loco.orderBook.generateExistingOrders(howMany: 1)
            }
        }

        let locoWithOrders = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
            }

        XCTAssert(locoWithOrders.count == Constants.Board.decks)

        // test generations
        let greenGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .green)
        XCTAssert(greenGenerations?.count == Constants.Board.numberOfDecksForColor(color: .green))

        let redGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .red)
        XCTAssert(redGenerations?.count == Constants.Board.numberOfDecksForColor(color: .red))

        let blueGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .blue)
        XCTAssert(blueGenerations?.count == Constants.Board.numberOfDecksForColor(color: .blue))

        let yellowGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .yellow)
        XCTAssert(yellowGenerations?.count == Constants.Board.numberOfDecksForColor(color: .yellow))
    }

    // Note - This is testing with 5 player game
    func testNoChange() {

        let ob = ObsolescenceManager.init(locos: locos)

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

        // force unlock first loco
        guard let firstloco = locos.first else {
            XCTFail("No loco found")
            return
        }

        XCTAssert(firstloco.orderBook.existingOrders.count == 1)

        let locoWithOrders = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
        }

        XCTAssert(locoWithOrders.count == 1)

        let ob = ObsolescenceManager.init(locos: locoWithOrders)
        ob.handler()

        print (locoWithOrders.description)

        XCTAssert(firstloco.orderBook.existingOrders.count == 2, "\(firstloco.orderBook.existingOrders.count)")
        XCTAssert(firstloco.orderBook.completedOrders.count == 0)

        print ("firstloco.orders = \(firstloco.orderBook.existingOrders)")
    }

    // mock the deck so that it will have 2 green generations valid
    func testTwoGenerations() {

        // force unlock loco
        for index in 0...4 {
            if (locos[index].orderBook.existingOrders.count == 0) {
                locos[index].orderBook.generateExistingOrders(howMany: 1)
            }
        }

        let locoWithOrders = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
            }

        XCTAssert(locoWithOrders.count == 5)

        // Transfer all orders to completed orders
        for loco in locoWithOrders {
            for (index, item) in loco.orderBook.existingOrders.enumerated() {
                loco.orderBook.transferOrder(order: item, index: index)
            }
        }

        let countExisting = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
        }.count

        let countCompleted = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.completedOrders.count > 0)
        }.count

        XCTAssert(countExisting == 0)
        XCTAssert(countCompleted == 5)

        // test generations 
        guard let greenGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .green) else {
            return
        }

        guard let firstGreenloco = greenGenerations.first else {
            return
        }
        guard let lastGreenloco = greenGenerations.last else {
            return
        }

        XCTAssert(firstGreenloco.orderBook.completedOrders.count == 1)

        XCTAssert(greenGenerations.count == 2)

        guard let redGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .red) else {
            return
        }
        XCTAssert(redGenerations.count == 1)

        guard let blueGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .blue) else {
            return
        }
        XCTAssert(blueGenerations.count == 1)

        guard let yellowGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .yellow) else {
            return
        }
        XCTAssert(yellowGenerations.count == 1)

        let ob = ObsolescenceManager.init(locos: locoWithOrders)
        ob.handler()

        // 1st loco
        XCTAssert(firstGreenloco.engineColor == .green)
        XCTAssert(firstGreenloco.generation == .first)
        XCTAssert(firstGreenloco.orderBook.existingOrders.count == 0, "\(firstGreenloco.orderBook.existingOrders.count)")
        XCTAssertTrue(firstGreenloco.isRusting)

        // 2nd loco
        XCTAssert(lastGreenloco.engineColor == .green)
        XCTAssert(lastGreenloco.generation == .second)
        XCTAssert(lastGreenloco.orderBook.existingOrders.count == 2)

        let countRusting = locos.filter({ (loco: Locomotive) -> Bool in
            return (loco.isRusting)
        }).count

        let countHasRusted = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.hasRusted)
        }.count

        XCTAssert(countRusting == 1)
        XCTAssert(countHasRusted == 0)
    }

    // mock the deck so that it will have 3 generations valid
    func testThreeGenerations() {
        // force unlock loco
        for index in 0...7 {
            if (locos[index].orderBook.existingOrders.count == 0) {
                locos[index].orderBook.generateExistingOrders(howMany: 1)
            }
        }

        let locoWithOrders = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
        }

        XCTAssert(locoWithOrders.last?.engineColor == .green)
        XCTAssert(locoWithOrders.count == 8)

        // Transfer all to completed orders
        for loco in locoWithOrders {
            for (index, item) in loco.orderBook.existingOrders.enumerated() {
                loco.orderBook.transferOrder(order: item, index: index)
            }
        }
        let countExisting = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.existingOrders.count > 0)
            }.count

        let countCompleted = locos.filter { (loco: Locomotive) -> Bool in
            return (loco.orderBook.completedOrders.count > 0)
            }.count

        XCTAssert(countExisting == 0)
        XCTAssert(countCompleted == 8)


        // test generations
        guard let greenGenerations = ObsolescenceManager(locos: locoWithOrders).findGenerationsForEngineColor(engineColor: .green) else {
            return
        }

        XCTAssert(greenGenerations.count == 3)

        for (index, loco) in locoWithOrders.enumerated() {
            print ("#\(index), \(loco.name), orders: \(loco.existingOrders), completedOrders: \(loco.completedOrders), rusting: \(loco.isRusting), hasRusted: \(loco.hasRusted)")
        }

        // start obsolescence of 3 generations
        let ob = ObsolescenceManager.init(locos: locoWithOrders)
        ob.handler()

        for (index, loco) in locoWithOrders.enumerated() {
            print ("#\(index), \(loco.name), orders: \(loco.existingOrders), completedOrders: \(loco.completedOrders), rusting: \(loco.isRusting), hasRusted: \(loco.hasRusted)")
        }

        let isRusting = locoWithOrders.filter { (loco: Locomotive) -> Bool in
            return (loco.isRusting)
        }

        let hasRusted = locoWithOrders.filter { (loco: Locomotive) -> Bool in
            return (loco.hasRusted)
        }

        XCTAssert(isRusting.count == 2)
        XCTAssert(hasRusted.count == 1)

        guard let firstRusted = hasRusted.first else {
            return
        }

        XCTAssert(firstRusted.engineColor == .green)
        XCTAssert(firstRusted.generation == .first)
    }
        
}

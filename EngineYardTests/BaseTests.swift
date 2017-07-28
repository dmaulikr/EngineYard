//
//  BaseTests.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest
import RealmSwift

@testable import EngineYard

class BaseTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        // Called once before all tests are run
        var uniqueConfiguration = Realm.Configuration.defaultConfiguration
        uniqueConfiguration.deleteRealmIfMigrationNeeded = true
        uniqueConfiguration.inMemoryIdentifier = "tests"
        Realm.Configuration.defaultConfiguration = uniqueConfiguration
    }

    override func setUp() {
        super.setUp()
        let realm = try! Realm()
        try! realm.write { () -> Void in
            realm.deleteAll()
        }
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGameObject() {
        let gameObj: Game = Game.init()
        XCTAssertFalse(gameObj.inProgress)
        XCTAssertNil(gameObj.gameBoard)
    }

    func testGamePreparation() {
        let expectedPlayers = Constants.NumberOfPlayers.max
        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: expectedPlayers) else {
            XCTFail("No mock players generated")
            return
        }
        XCTAssert(mockPlayers.count == expectedPlayers)

        guard let gameObj = Game.setup(players: mockPlayers) else {
            return
        }

        XCTAssertNotNil(gameObj)
        XCTAssertNotNil(gameObj.dateCreated)
        XCTAssertNotNil(gameObj.gameBoard)

        guard let gameBoard = gameObj.gameBoard else {
            XCTFail("Game board not prepared")
            return
        }

        XCTAssert(gameBoard.decks.count == Constants.Board.decks)

    }

}

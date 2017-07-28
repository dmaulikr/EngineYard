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

    func testGameObject() {
        let expectedPlayers = Constants.NumberOfPlayers.max
        guard let mockPlayers = PlayerAPI.generateMockPlayers(howMany: expectedPlayers) else {
            XCTFail("No mock players generated")
            return
        }
        XCTAssert(mockPlayers.count == expectedPlayers)

        Game.setup(players: mockPlayers) { (game) in
            XCTAssertNotNil(game)

            if let gameObj = game {
                guard let gameBoard = gameObj.gameBoard else {
                    XCTFail("No game board generated")
                    return
                }
                XCTAssert(gameBoard.decks.count == Constants.Board.decks)
            }
        }


    }

}

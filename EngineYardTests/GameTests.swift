//
//  GameTests.swift
//  EngineYard
//
//  Created by Amarjit on 21/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class GameTests: BaseTests {

    var game: Game = Game.instance

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGameInProgress() {
        XCTAssertFalse(self.game.inProgress)

        self.game.gameBoard = GameBoard.prepare()
        XCTAssertTrue(self.game.inProgress)
    }

}

//
//  BaseTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

struct Mock
{
    public static func players(howMany:Int) -> [Player]? {
        var players: [Player] = [Player]()

        do {
            if try Constants.NumberOfPlayers.isValid(count: howMany)
            {
                for index in stride(from:0, to: howMany, by: 1) {
                    let playerObj = Player.init(name: "Player #\(index)", asset: nil)
                    players.append(playerObj)
                }

                return players
            }
            else {
                assertionFailure("number of players is invalid: \(howMany)")
                return nil
            }

        } catch let error {
            assertionFailure(error.localizedDescription)
            return nil
        }
    }
}

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

    func testGamePreparation() {
        let expectedPlayers = Constants.NumberOfPlayers.max

        guard let generatedPlayers = Mock.players(howMany: expectedPlayers) else {
            XCTFail("No mock players generated")
            return
        }
        XCTAssert(generatedPlayers.count == expectedPlayers)

        guard let gameObj = Game.setup(players: generatedPlayers) else {
            assertionFailure("** No game object defined **")
            return
        }

        XCTAssertNotNil(gameObj)
        XCTAssertNotNil(gameObj.dateCreated)

        XCTAssertNotNil(gameObj.gameBoard)
        XCTAssert(gameObj.gameBoard?.decks.count == Constants.Board.decks)
        XCTAssert(gameObj.players.count == expectedPlayers)
    }
}

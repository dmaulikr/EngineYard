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
            print ("Player setup error: \(error.localizedDescription as Any)")
            return nil
        }
    }

    struct Cards {
        var green: Int = 0
        var red: Int = 0
        var blue: Int = 0
        var yellow: Int = 0
        var total : Int {
            return (self.green + self.red + self.blue + self.yellow)
        }

        fileprivate struct Expected {
            static let green = Constants.Board.numberOfCardsForColor(engineColor: .green)
            static let red = Constants.Board.numberOfCardsForColor(engineColor: .red)
            static let blue = Constants.Board.numberOfCardsForColor(engineColor: .blue)
            static let yellow = Constants.Board.numberOfCardsForColor(engineColor: .yellow)
            static let total = Constants.Board.cards
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
            XCTFail("** No game object defined **")
            return
        }

        guard let gameBoard = gameObj.gameBoard else {
            XCTFail("** No game board defined **")
            return
        }

        XCTAssertNotNil(gameObj)
        XCTAssertNotNil(gameObj.dateCreated)
        XCTAssert(gameObj.players.count == expectedPlayers)
        XCTAssert(gameBoard.decks.count == Constants.Board.decks)

        let unlocked = TrainAPI.countUnlockedDecks(in: gameBoard)
        XCTAssert(unlocked == 1)

        // Validate board decks
        var cards = Mock.Cards()

        for train in gameBoard.decks
        {
            XCTAssert(train.cost % 4 == 0)
            XCTAssert(train.productionCost == Int(train.cost / 2))
            XCTAssert(train.income == Int(train.productionCost / 2))

            print (train.description)

            let orders = train.existingOrders.count
            let howMany = (train.capacity - orders)
            XCTAssertTrue(train.orderBook.canGenerateExistingOrders(howMany: howMany, forTrain: train))
            XCTAssertFalse(train.orderBook.canGenerateExistingOrders(howMany: howMany + 1, forTrain: train))

            for _ in train.cards {
                switch train.engineColor {
                case .green:
                    cards.green += 1
                    break

                case .red:
                    cards.red += 1
                    break

                case .blue:
                    cards.blue += 1
                    break

                case .yellow:
                    cards.yellow += 1
                    break
                }
            }
        }

        XCTAssert(cards.green == Mock.Cards.Expected.green, "Not enough green cards. Found: \(cards.green), Expected: \(Mock.Cards.Expected.green)")
        XCTAssert(cards.red == Mock.Cards.Expected.red, "Not enough red cards. Found: \(cards.red), Expected: \(Mock.Cards.Expected.red)")
        XCTAssert(cards.yellow == Mock.Cards.Expected.yellow, "Not enough yellow cards. Found: \(cards.yellow), Expected: \(Mock.Cards.Expected.yellow)")
        XCTAssert(cards.blue == Mock.Cards.Expected.blue, "Not enough blue cards. Found: \(cards.blue), Expected: \(Mock.Cards.Expected.blue)")
        XCTAssert(cards.total == Mock.Cards.Expected.total, "Not enough cards, total = \(cards.total), Expected: \(Mock.Cards.Expected.total)")


    }

}

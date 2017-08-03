//
//  TaxTests.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import XCTest

@testable import EngineYard

class TaxTests: BaseTests {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTaxDue() {
        let balance = 300
        let newBalance = Tax.pay(onBalance: balance)
        let taxDue = Tax.calculateTaxDue(onBalance: balance)
        XCTAssert(newBalance == (balance - taxDue))
    }

    func testSalesTax() {
        let balance = 300
        let expected = 330
        let newBalance = Tax.addSalesTax(toBalance: balance)
        XCTAssert(newBalance == expected)
    }

    func testTaxOnWallet() {
        // simulate 5 players wallets
        var wallets: [Wallet] = [Wallet]()
        for _ in 1...5 {
            let wallet = Wallet.init(balance: 100)
            wallets.append(wallet)
        }

        let _ = wallets.map({$0.debit(amount: Tax.calculateTaxDue(onBalance: $0.balance))})

        let _ = wallets.map({
            XCTAssert($0.balance == 90)
        })
    }

    func testTaxViewModel() {
        let deposit = 100
        let expectedTaxDue = 10
        let expectedBalance = 90

        let wallet = Wallet.init(balance: deposit)

        var taxModel = PlayerTaxViewModel.init(amount: wallet.balance)

        XCTAssertTrue(taxModel.beforeTax == deposit)
        XCTAssertTrue(taxModel.taxDue == expectedTaxDue)
        XCTAssertTrue(taxModel.afterTax == expectedBalance)

        XCTAssertTrue(taxModel.formattedPreTaxBalance == "$100", "\(taxModel.formattedPreTaxBalance)")
        XCTAssertTrue(taxModel.formattedTaxDue == "$10", "\(taxModel.formattedTaxDue)")
        XCTAssertTrue(taxModel.formattedBalance == "$90", "\(taxModel.formattedBalance)")        
    }

    func testPlayerTurnOrderAfterTax() {
        // expect the players to be in reverse turn order after applying tax
        // I expect after applying tax & turn order that the first player will be last


        guard let mockPlayers = Mock.players(howMany: 5) else {
            XCTFail("No players generated")
            return
        }

        guard let game = Game.setup(players: mockPlayers) else {
            XCTFail("Game setup failed")
            return
        }

        let _ = game.players.map({
            XCTAssertTrue( $0.wallet.balance == Constants.SeedCash.fivePlayers )
        })

        // force credit the players cash
        let turnOrderBefore = game.turnOrderManager.turnOrder

        var counter = game.players.count
        for player in game.players {
            let balance = player.wallet.balance
            let deposit = Int(counter * (31 - counter))
            let expected = (balance + deposit)

            player.wallet.credit(amount: deposit)

            XCTAssertTrue(player.wallet.balance == expected)

            counter -= 1
        }

        print ("\n balances:")

        let _ = game.players.map({
            print ("player: \($0.name), $\($0.wallet.balance)")
        })

        // I expect after applying tax & turn order that the first player will be last
        guard let firstPlayerBefore = TurnOrderManager.instance.turnOrder.first else {
            XCTFail("No player found")
            return
        }
        guard let lastPlayerBefore = TurnOrderManager.instance.turnOrder.last else {
            XCTFail("No player found")
            return
        }

        print ("\nAFTER TAX: ")

        PlayerAPI.applyTax(players: game.players) { (complete) in
            if (complete) {
                let _ = game.players.map({
                    print ("player: \($0.name), $\($0.wallet.balance)")
                })
            }
        }

        print ("\nturnOrderBEFORE :")

        for (index, player) in turnOrderBefore.enumerated() {
            print ("#\(index), \(player.name) turnOrder: \(player.turnOrder), \(player.wallet.balance)")
            XCTAssertTrue(player.turnOrder == index)
        }



        let sorted = (PlayerAPI.sortPlayersByLowestCash(players: game.players))

        game.turnOrderManager.turnOrder = sorted

        let turnOrderAfter = game.turnOrderManager.turnOrder

        print ("\nturnOrderAFTER :")

        for (index, player) in turnOrderAfter.enumerated() {
            print ("#\(index), \(player.name) turnOrder: \(player.turnOrder), \(player.wallet.balance)")
        }

        // I expect after applying tax & turn order that the first player will be last
        guard let firstPlayerAfter = TurnOrderManager.instance.turnOrder.first else {
            XCTFail("No player found")
            return
        }
        guard let lastPlayerAfter = TurnOrderManager.instance.turnOrder.last else {
            XCTFail("No player found")
            return
        }

        XCTAssertTrue(firstPlayerAfter == lastPlayerBefore)
        XCTAssertTrue(lastPlayerAfter == firstPlayerBefore)
        XCTAssertTrue(firstPlayerAfter.turnOrder == 0)
        XCTAssertTrue(lastPlayerAfter.turnOrder == 4)


    }

}

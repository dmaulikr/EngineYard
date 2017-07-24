//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

struct Tax {

    // Subtract tax from a balance
    // Players pay taxes, rounded down
    public static func pay(onBalance: Int) -> Int {
        let taxDue: Int = self.calculate(onBalance: onBalance)
        return Int(onBalance - taxDue)
    }

    // Round down tax due, cast as Int
    public static func calculate(onBalance: Int) -> Int {
        let balance: Float = Float(onBalance)
        let taxDue: Int = Int(floor(balance * Constants.taxRate))
        return taxDue
    }

    // MARK: (Private) functions

    // Add tax to a balance
    public static func addSalesTax(toBalance: Int) -> Int {
        let salesTax: Int = self.calculate(onBalance: toBalance)
        return Int(toBalance + salesTax)
    }

    public static func applyTax(players: [Player]) -> [Player] {
        _ = players.map({
            let balance = $0.account.balance

            let taxDue = Tax.calculate(onBalance: balance)

            if (taxDue > 0) {
                $0.account.debit(amount: taxDue)
            }
        })

        return players
    }

}

/*
struct Tax {

    var balance : Int

    init(balance: Int) {
        self.balance = balance
    }

    // only calculates the tax due
    func calculate() -> Float {
        let cash: Float = Float(self.balance)
        let sum: Float = (floor(cash * Constants.taxRate))
        return sum
    }

    func pay() -> Int {
        let taxableAmount: Float = self.calculate()
        let result: Int = self.subtractTax(amountToRemove: taxableAmount)
        return result
    }

    func addSalesTax() -> Int {
        let taxableAmount:Float = self.calculate()
        let sum: Int = self.addTax(amountToAdd: taxableAmount)
        return sum
    }

    // Add tax on a given amount
    private func addTax(amountToAdd: Float) -> Int {
        let sum:Float = ( Float(self.balance) + amountToAdd )
        return Int(sum)
    }

    // Subtract tax on a given amount
    private func subtractTax(amountToRemove: Float) -> Int {
        let sum: Float = (Float(self.balance) - amountToRemove)
        return Int(sum)
    }

    public static func applyTax(players: [Player]) -> [Player] {
        _ = players.map({
            let balance = $0.account.balance
            let taxDue = Int(Tax(balance: balance).calculate())
            if (taxDue > 0) {
                $0.account.debit(amount: taxDue)
            }
        })
        return players
    }
    
}
*/

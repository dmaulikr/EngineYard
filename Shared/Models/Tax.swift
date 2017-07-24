//
//  Tax.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

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

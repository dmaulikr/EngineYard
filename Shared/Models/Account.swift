//
//  Account.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// A player's account
// Note: - The game has no concept of currency; it uses Int's
//
struct Account: CustomStringConvertible  {
    public fileprivate(set) var balance: Int = 0

    var description: String {
        return ("Balance: $\(self.balance)")
    }

    init(balance:Int = 0) {
        self.balance = balance
    }

    mutating func credit(amount: Int) {
        if (canCredit(amount: amount)) {
            self.balance += amount
        }
    }

    mutating func debit(amount: Int) {
        if (canDebit(amount: amount)) {
            self.balance -= amount
        }
    }

    func canAfford(amount: Int) -> Bool {
        return (self.canDebit(amount: amount))
    }

    private func canCredit(amount: Int) -> Bool {
        guard amount > 0 else {
            return false
        }
        return true
    }

    private func canDebit(amount: Int) -> Bool {
        guard amount > 0 else {
            return false
        }
        guard self.balance > amount else {
            return false
        }
        guard (self.balance - amount > 0) else {
            return false
        }
        return true
    }
}

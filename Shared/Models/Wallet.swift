//
//  Wallet.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// A player's wallet/cash, only uses Ints
// Note: - The game has no concept of currency; it uses Int's

struct Wallet: CustomStringConvertible  {
    public private(set) var balance: Int = 0

    var description: String {
        return ("Balance: $\(self.balance)")
    }

    init(balance: Int = 0) {
        self.balance = balance
    }

    mutating func credit(amount: Int) {
        if (self.canCredit(amount: amount)) {
            self.balance += amount
        }
    }

    mutating func debit(amount: Int) {
        if (self.canDebit(amount: amount)) {
            self.balance -= amount
        }
    }

    internal func canCredit(amount: Int) -> Bool {
        guard amount > 0 else {
            return false
        }
        return true
    }

    internal func canDebit(amount: Int) -> Bool {
        guard amount > 0 else {
            return false
        }
        guard self.balance >= amount else {
            return false
        }
        guard (self.balance - amount >= 0) else {
            return false
        }
        return true
    }

}

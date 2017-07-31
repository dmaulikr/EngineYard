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

class Wallet: CustomStringConvertible  {
    public private(set) var balance: Int = 0 {
        didSet {
            if (balance > 999) {
                balance = 999
            }
            if (balance < -999) {
                balance = -999
            }
        }
    }

    init(balance: Int = 0) {
        self.balance = balance
    }

    func credit(amount: Int) {
        if (self.canCredit(amount: amount)) {
            self.balance += amount
        }
    }

    func debit(amount: Int) {
        if (self.canDebit(amount: amount)) {
            self.balance -= amount
        }
    }

    // MARK: - (Private) functions

    func canAfford(amount: Int) -> Bool {
        return (self.canDebit(amount: amount))
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

extension Wallet {

    var description: String {
        return ("Balance: $\(self.balance)")
    }

}

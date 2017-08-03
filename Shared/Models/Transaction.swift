//
//  Transaction.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// #TODO
struct Transaction: CustomStringConvertible
{
    let dateCreated: Date = Date.init(timeIntervalSinceNow: 0)
    var amount: Int = 0
    var note: String = ""

    init(amount: Int, note: String?) {
        self.amount = amount
        if let noteObj = note {
            self.note = noteObj
        }
    }
}

extension Transaction {
    var description: String {
        return ("Transaction: \(self.dateCreated) - Amount: \(self.amount) - Note: \(self.note)")
    }
}

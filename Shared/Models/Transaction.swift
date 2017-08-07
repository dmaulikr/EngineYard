//
//  Transaction.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

struct Transaction
{
    private var dateCreated = Date.init(timeIntervalSinceNow: 0)
    var amount: Int
    var note: String?

    init(amount: Int, note: String? = nil) {
        self.amount = amount
        guard let hasNote = note else {
            return
        }
        self.note = hasNote
    }
}

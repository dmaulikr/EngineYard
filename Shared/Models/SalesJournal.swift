//
//  SalesJournal.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// This is not a strict sales journal, sales ledger; 
// its actually a record of sales made

class SalesJournal {
    weak var owner: Player?
    weak var engine: Engine?
    var entries : [SalesLedger] = [SalesLedger]()
}

struct SalesLedger {
    var unitsSold: Int?
    var perUnitPrice: Int?
    var total: Int {
        guard let units = unitsSold else {
            return 0
        }
        guard let income = perUnitPrice else {
            return 0
        }
        return (units * income)
    }
}

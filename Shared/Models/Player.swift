//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Player : NSObject {
    public fileprivate(set) var name : String!
    public fileprivate(set) var isAI: Bool = false
    public fileprivate(set) var asset: String = ""
    public fileprivate(set) var turnOrder: Int = 0

    lazy var portfolio: Portfolio = Portfolio(owner: self)
    var wallet: Wallet = Wallet()
    var cash: Int {
        return (self.wallet.balance)
    }

    override var description: String {
        return ("\(self.name), turnOrder: \(self.turnOrder), cash: $\(self.cash)")
    }

    init(name: String, isAI: Bool = false, asset: String?) {
        super.init()
        self.name = name
        self.isAI = isAI
        if let hasAsset = asset {
            self.asset = hasAsset
        }
    }
}


extension Player {

    func setTurnOrderIndex(number: Int) {
        self.turnOrder = number
    }
    
}

//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Player : NSObject {
    public fileprivate(set) var name: String = ""
    public fileprivate(set) var isAI: Bool = false
    public fileprivate(set) var asset: String = ""
    public fileprivate(set) var turnOrder: Int = 0

    var account: Account = Account()
    lazy var portfolio: Portfolio = Portfolio(owner: self)

    var cash: Int {
        return self.account.balance
    }

    override var description: String {
        return ("\(self.name), turnOrder: \(self.turnOrder), cash: $\(self.cash)")
    }

    init(name:String, isAI:Bool = false, asset:String?) {
        self.name = name
        self.isAI = isAI

        if let hasAsset = asset {
            self.asset = hasAsset
        }

        super.init()
    }
}

extension Player {

    func setTurnOrderIndex(number:Int) {
        self.turnOrder = number
    }

    func toggleIsAI() {
        self.isAI = !self.isAI
    }

}

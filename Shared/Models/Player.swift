//
//  Player.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

final class Player : CustomStringConvertible, Equatable
{
    let uuid: String = UUID().uuidString
    public fileprivate(set) var name : String = ""
    public fileprivate(set) var isAI: Bool = false
    public fileprivate(set) var asset: String = ""
    public fileprivate(set) var turnOrder: Int = 0

    lazy var hand: Hand = Hand(owner: self) // hand of cards
    var wallet: Wallet = Wallet() // in-game cash wallet

    var cash: Int {
        return (self.wallet.balance)
    }

    init(name: String, isAI: Bool = false, asset: String?) {
        self.name = name
        self.isAI = isAI
        if let hasAsset = asset {
            self.asset = hasAsset
        }
    }
}

extension Player {
    var description: String {
        return ("\(self.name), turnOrder: \(self.turnOrder), cash: $\(self.cash)")
    }
}

extension Player {
    public static func ==(lhs: Player, rhs: Player) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
}

extension Player {

    func setTurnOrderIndex(number: Int) {
        self.turnOrder = number
    }

    func canPurchase(train: Train) -> Bool {
        print ("train: \(train.description)")

        

        return true
    }

}

//
//  TurnOrderManager.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation


protocol TurnDelegate: NSObjectProtocol {
    func turnDidEnd()
    func allTurnsDidComplete()
}

protocol TurnOrderManagerDelegate: NSObjectProtocol {
    func turnOrderWasSet()
}

class TurnOrderManager : NSObject, TurnOrderManagerDelegate {
    static var instance = TurnOrderManager()

    var turnOrder: [Player] = [Player]() {
        didSet {
            self.turnOrderWasSet()
        }
    }

    var current: Player {
        return self.turnOrder[self.turnOrderIndex]
    }

    override init() {
        super.init()
    }

    public private(set) var turnOrderIndex: Int = 0

    internal func turnOrderWasSet() {
        for (index, p) in self.turnOrder.enumerated() {
            p.setTurnOrderIndex(number: index)
        }
    }

    public func shuffleTurnOrder() {
        self.turnOrder.shuffle()
    }

    public func next() {
        if (turnOrderIndex < (self.turnOrder.count - 1)) {
            turnOrderIndex += 1
        }
        else {
            turnOrderIndex = 0
        }
    }
    
}

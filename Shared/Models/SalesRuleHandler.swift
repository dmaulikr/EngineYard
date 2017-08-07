//
//  SalesRuleHandler.swift
//  EngineYard
//
//  Created by Amarjit on 07/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

public enum SalesRuleType
{
    case perfect
    case lower
    case higher
}


public struct SalesRuleHandler
{
    public private(set) var orders: [Int]
    public private(set) var units: Int

    public var ruleType: SalesRuleType?
    private var match: (Int, Int)?

    init(orders: [Int], units: Int)
    {
        self.orders = orders
        self.units = units

        let rule = SalesRule(orders: orders)

        if let perfectMatch = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(perfectMatch.0) which is the value \(perfectMatch.1)")

            self.ruleType = .perfect
            self.match = perfectMatch

        } else {

            if let lowerMatch = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(lowerMatch.0) which is the value \(lowerMatch.1)")

                self.ruleType = .lower
                self.match = lowerMatch

            } else {

                if let higherMatch = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(higherMatch.0)  which is the value \(higherMatch.1)")

                    self.ruleType = .higher
                    self.match = higherMatch
                    
                } else {
                    return
                }
            }
        }
    }

    mutating func handle() {

        guard let ruleType = self.ruleType else {
            return
        }
        guard let match = self.match else {
            return
        }

        switch ruleType {

        case .perfect:
            handlePerfect(match: match)
            break

        case .lower:
            handleLower(match: match)
            break

        case .higher:
            handleHigher(match: match)
            break
        }
    }


    private mutating func handlePerfect(match: (Int, Int)) {

        // add transaction here
        assert(match.1 == self.units)
        self.orders[match.0] -= match.1
        self.units -= match.1
    }

    private mutating func handleLower(match: (Int, Int)) {

        // add transaction here
        self.orders[match.0] -= self.units
        self.units -= self.units
    }

    private mutating func handleHigher(match: (Int, Int)) {

        // add transaction here
        let remainingUnits = self.units - match.1
        self.orders[match.0] -= (self.units - remainingUnits)
        self.units = remainingUnits
    }



}

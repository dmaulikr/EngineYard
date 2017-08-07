//
//  SalesRuleHandler.swift
//  EngineYard
//
//  Created by Amarjit on 07/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

enum SalesRuleType
{
    case perfect
    case lower
    case higher
}


struct SalesRuleHandler
{
    var ruleType : SalesRuleType?

    init(orders: [Int], units: Int)
    {
        let rule : SalesRule = SalesRule.init(orders: orders)

        if let match = rule.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(rule.orders) at index: \(match.0) which is the value \(match.1)")

            ruleType = .perfect

        } else {

            if let lower = rule.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(rule.orders) at index: \(lower.0) which is the value \(lower.1)")

                ruleType = .lower

            } else {

                if let higher = rule.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(rule.orders) at index: \(higher.0)  which is the value \(higher.1)")

                    ruleType = .higher

                } else {
                    return
                }
            }
        }
    }

}

//
//  SalesRule.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

enum SalesMatchCase {
    case lower
    case perfectMatch
    case higher
}

struct SalesMatchHandler {
    var matchCase: SalesMatchCase = .lower
    var salesMatch: SalesMatch!

    init(orders:[Int], goods: Int) {
        self.salesMatch = SalesMatch.init(orders: orders)

        let orders = self.salesMatch.orders

        if let perfectMatch = self.salesMatch.perfectMatch(goods) {
            print("Found perfect match for: \(goods) in orders \(orders) at index: \(perfectMatch.0) which is the value \(perfectMatch.1)")
            self.matchCase = .perfectMatch
        }
        else {
            if let lowerMatch = self.salesMatch.lowerMatch(goods) {
                print("Found lower match for: \(goods) in orders \(orders) at index: \(lowerMatch.0) which is the value \(lowerMatch.1)")
                self.matchCase = .lower
            }
            else {
                if let higherMatch = self.salesMatch.higherMatch(goods) {
                    print("Found higher match for: \(goods) in orders \(orders) at index: \(higherMatch.0)  which is the value \(higherMatch.1)")
                    self.matchCase = .higher
                }
                else {
                    print("Sales rule failure for \(orders), units: \(goods)")
                    exit(-1)
                }
            }
        }
    }
}


struct SalesMatch {
    private var _orders: [Int]
    var orders: [Int] {
        return _orders
    }

    init(orders: [Int]) {
        _orders = orders
    }

    func perfectMatch(_ good: Int) -> (Int, Int)? {
        var match = _orders.enumerated().filter {
            good == $0.element
        }

        match = match.flatMap {
            [($0.offset, $0.element)]
        }
        return match.first
    }

    func lowerMatch(_ good: Int) -> (Int, Int)? {
        let lower = _orders.enumerated().max {
            a, b in
            return a.element > b.element
        }

        let upper = _orders.enumerated().max {
            a, b in
            return a.element < b.element
        }

        guard let lowerValue = lower?.1, let upperValue = upper?.1 else {
            return nil
        }

        let range = Range(uncheckedBounds: (lowerValue, upperValue))
        let inRange = range.contains(good)

        if inRange || good < range.lowerBound {
            return upper
        } else {
            return nil
        }
    }

    func higherMatch(_ good: Int) -> (Int, Int)? {
        let upper = _orders.enumerated().max {
            a, b in
            return a.element < b.element
        }

        guard let upperValue = upper?.element else {
            return nil
        }

        if good > upperValue {
            return upper
        } else {
            return nil
        }
    }
}

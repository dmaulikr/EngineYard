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
    var match: SalesMatch!
    var matchTuple:(Int,Int)!

    init(orders:[Int], units: Int) {
        self.match = SalesMatch.init(orders: orders)

        let orders = self.match.orders

        if let perfectMatch = self.match.perfectMatch(units) {
            print("Found perfect match for: \(units) in orders \(orders) at index: \(perfectMatch.0) which is the value \(perfectMatch.1)")
            self.matchCase = .perfectMatch
            self.matchTuple = perfectMatch
        }
        else {
            if let lowerMatch = self.match.lowerMatch(units) {
                print("Found lower match for: \(units) in orders \(orders) at index: \(lowerMatch.0) which is the value \(lowerMatch.1)")
                self.matchCase = .lower
                self.matchTuple = lowerMatch
            }
            else {
                if let higherMatch = self.match.higherMatch(units) {
                    print("Found higher match for: \(units) in orders \(orders) at index: \(higherMatch.0)  which is the value \(higherMatch.1)")
                    self.matchCase = .higher
                    self.matchTuple = higherMatch
                }
                else {
                    assertionFailure("Sales rule failure for \(orders), units: \(units)")
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

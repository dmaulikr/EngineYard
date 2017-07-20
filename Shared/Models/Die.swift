//
//  Die.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import GameplayKit

// Handles die rolls only

extension Int {
    static func randomInt(withMax: Int) -> Int {
        let maximum = UInt32(withMax)
        return 1 + Int(arc4random_uniform(maximum))
    }
}

struct Die {
    static func roll() -> Int {
        if #available(iOS 9, *) {
            let d6 = GKRandomDistribution.d6()
            return (d6.nextInt())
        }
        else {
            let d6 = 6
            return Int.randomInt(withMax:d6)
        }
    }

    static func assetNameForValue(dieValue:Int) -> String {
        return "die-face-\(dieValue)"
    }
}

//
//  Engine+API.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class EngineAPI : NSObject {

    public static func findParentLocomotivesMatchingUUID(engines:[Engine], uuid:String) -> [Engine] {
        let results = engines.filter({ (eng:Engine) -> Bool in
            return (eng.parent?.uuid == uuid)
        })
        return results
    }

    public static func createEnginesFor(train:Locomotive) {
        guard train.engines.count == 0 else {
            return
        }
        for _ in stride(from:0, to: train.numberOfChildren, by: 1) {
            let engine : Engine = Engine.init(parent: train)
            train.engines.append(engine)
        }
    }

    public static func filterEngineColor(matchingParent:Locomotive) -> [Engine] {
        let results = matchingParent.engines.filter({ (eng:Engine) -> Bool in
            return (eng.parent?.engineColor == matchingParent.engineColor)
        })

        return results
    }
    
}

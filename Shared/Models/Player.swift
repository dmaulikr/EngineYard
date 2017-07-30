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

    init(name: String) {
        super.init()
        self.name = name
    }
}

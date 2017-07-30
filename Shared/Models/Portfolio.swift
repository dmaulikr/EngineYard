//
//  Portfolio.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class Portfolio : NSObject
{
    weak var owner: Player?

    init(owner: Player) {
        super.init()
        self.owner = owner
    }
}

//
//  LocomotiveCard.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

typealias Locomotive = LocomotiveCard

class LocomotiveCard : NSObject
{
    weak var parent: Train?
    weak var owner: Player?
    weak var production: Production?

    init(parent: Train) {
        super.init()
        self.parent = parent
        self.production = Production.init(parent: self)
    }

}

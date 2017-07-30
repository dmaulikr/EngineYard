//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class Production : NSObject
{
    weak var parent: LocomotiveCard?
    var units: Int = 0
    private var unitsSpent: Int = 0

    init(parent: LocomotiveCard) {
        super.init()
        self.parent = parent
    }
}

extension Production {
    func setDefaultProduction() {
        self.units = 1
    }
}

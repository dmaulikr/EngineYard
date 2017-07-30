//
//  Production.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Production: HandDelegate
{
    weak var parent: LocomotiveCard?
    var units: Int = 0
    private var unitsSpent: Int = 0

    init(parent: LocomotiveCard) {
        self.parent = parent
    }
}

extension Production {

    // #TODO
    internal func didAdd(card: LocomotiveCard) {
        self.setDefaultProduction()
    }

    private func setDefaultProduction() {
        self.units = 1
    }
}

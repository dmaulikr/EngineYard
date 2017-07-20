//
//  Engine.swift
//  EngineYard
//
//  Created by Amarjit on 20/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

final class Engine : NSObject {
    weak var parent: Locomotive?
    weak var owner: Player?
    lazy var production: Production = Production.init(parent: self)

    override var description: String {
        return ("Engine.parent: \(self.parent?.name), Owner: \(self.owner?.name) - Production: \(self.production.description)")
    }

    init(parent: Locomotive) {
        super.init()
        self.parent = parent
    }
}

extension Engine {

    func assignOwner(player: Player) {
        self.production.setDefaultProduction()

        self.owner = player
        self.owner?.addEngine(engine: self)
    }
}

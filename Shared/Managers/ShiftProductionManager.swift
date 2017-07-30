//
//  ShiftProductionManager.swift
//  EngineYard
//
//  Created by Amarjit on 24/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

// [Shift production]
//
// A player may shift Production Units from older technology
// locomotive cards to newer technology locomotive cards.
//
// A player can only ever shift production up the chain, ie:
// train A -> train B
//
// In addition, he must pay the difference
// of production costs to the Bank.
//
// If – after shifting capacities – a locomotive card has
// no Production Units, remove it from play immediately.
//

/**
struct ShiftablePortfolio {
    var engine: Engine
    var difference: Int = 0

    init(engine: Engine, startingEngine: Engine) {
        self.engine = engine
        self.difference = (self.engine.production.cost - startingEngine.production.cost)
    }
}

struct ShiftProductionManager {

    var player: Player
    var portfolio: [ShiftablePortfolio]?

    init(player: Player, engine: Engine) {
        self.player = player
        self.portfolio = self.buildPortfolio(fromEngine: engine)
    }

    private mutating func buildPortfolio(fromEngine:Engine) -> [ShiftablePortfolio]? {
        guard let thisTrain = fromEngine.parent else {
            return nil
        }
        let folio = self.player.engines.filter { (eng:Engine) -> Bool in
            return (
                (eng.production.units > 0) &&
                ((eng.parent?.cost)! > thisTrain.cost)
            )
            }.sorted { (eng1:Engine, eng2:Engine) -> Bool in
                return ((eng1.parent?.cost)! < (eng2.parent?.cost)!)
        }

        var portfolio: [ShiftablePortfolio] = [ShiftablePortfolio]()

        for engine in folio {
            let shiftableObj = ShiftablePortfolio.init(engine: engine, startingEngine: fromEngine)
            portfolio.append(shiftableObj)
        }

        if (portfolio.count == 0)
        {
            return nil
        }
        else {
            return portfolio
        }
    }

    
}
**/

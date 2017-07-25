//
//  MarketDemandsViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class MarketDemandsViewModel: NextStateTransitionProtocol
{
    var game: Game!

    // MARK: - NextStateTransitionProtocol

    internal func shouldTransitionToNextState() -> Bool {
        // true: if all turns complete
        return false
    }


    internal func transitionToNextState() {
        
    }
}

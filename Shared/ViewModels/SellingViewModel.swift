//
//  SellingViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class SellingViewModel: NextStateTransitionProtocol
{
    weak var game: Game?

    init(game: Game) {
        self.game = game
    }


    // MARK: - NextStateTransitionProtocol

    internal func shouldTransitionToNextState() -> Bool {
        // true: if all turns complete
        return false
    }


    internal func transitionToNextState() {
        
    }

}

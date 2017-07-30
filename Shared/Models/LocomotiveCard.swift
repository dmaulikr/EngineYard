//
//  LocomotiveCard.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

typealias Locomotive = LocomotiveCard

final class LocomotiveCard : CustomStringConvertible
{
    public fileprivate(set) weak var parent: Train?
    public fileprivate(set) weak var owner: Player?
    lazy var production: Production = Production.init(parent: self)

    init(parent: Train) {
        self.parent = parent
    }

    func setOwner(owner: Player) {
        self.owner = owner
    }
}

extension LocomotiveCard {
    var description: String {
        return ":LocomotiveCard"
    }
}

extension LocomotiveCard {

    func isOwned(by player: Player?) -> Bool {
        return self.owner === player
    }

}

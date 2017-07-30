//
//  LocomotiveCard.swift
//  EngineYard
//
//  Created by Amarjit on 30/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

typealias Locomotive = LocomotiveCard

final class LocomotiveCard : CustomStringConvertible, Equatable
{
    let uuid: String = UUID().uuidString
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
        guard let hasParent = self.parent else {
            return "No parent"
        }
        return hasParent.name
    }
}


extension LocomotiveCard {
    public static func ==(lhs: LocomotiveCard, rhs: LocomotiveCard) -> Bool {
        return (lhs.uuid == rhs.uuid)
    }
}


extension LocomotiveCard {

    func isOwned(by player: Player?) -> Bool {
        return self.owner === player
    }

}

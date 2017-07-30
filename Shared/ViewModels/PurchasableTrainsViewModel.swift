//
//  PurchasableTrainsViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 29/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

protocol PurchaseTrainProtocol {
    func canPurchaseTrain(train: Train) -> Bool
    func willPurchaseTrain(train: Train)
    func didPurchaseTrain(train: Train)
}

public struct Message {
    var title: String?
    var message: String

    init(title: String?, message: String) {
        if let titleObj = title {
            self.title = titleObj
        }
        self.message = message
    }

    static var endTurnMessage: Message = {
        let message: String = NSLocalizedString("Please press END TURN", comment: "End Turn")
        return Message.init(title: nil, message: message)
    }()

}

// Contains a list of purchasable trains
final class PurchaseableTrainsViewModel: BaseViewModel, PurchaseTrainProtocol
{
    override init(game: Game) {
        super.init(game: game)
    }

    var trains: [Train]?

    lazy var noTrainPurchasedMessage: Message = {
        let title: String = NSLocalizedString("End Turn -- Are you sure?", comment: "No train bought title")
        let message: String = NSLocalizedString("You didn't buy a train, are you sure you want to end your turn without buying a train?", comment: "No train bought message")
        return Message.init(title: title, message: message)
    }()

    lazy var purchaseTrainOrEndTurnMessage: Message = {
        let message: String = NSLocalizedString("Purchase a train, or END TURN", comment: "Purchase train, or end turn")
        return Message.init(title: nil, message: message)
    }()

    // PurchaseTrainProtocol delegate methods

    internal func canPurchaseTrain(train: Train) -> Bool {
        return false
    }

    internal func willPurchaseTrain(train: Train) {

    }

    internal func didPurchaseTrain(train: Train) {

    }
}

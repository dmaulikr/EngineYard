//
//  BuyTrainListViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 01/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation

class BuyTrainListViewModel : BaseViewModel
{
    enum SegueID: String {
        case buyTrainDetailSegue
        case productionSegue
        case unnamed = ""
    }

    var delegate: BuyTrainAlertProtocol?

    var validSegues = [SegueID.buyTrainDetailSegue, SegueID.productionSegue]

    let pageTitle: String = NSLocalizedString("Buy Train", comment: "Buy train page title")

    var selectedTrain: Train?

    lazy var trains: [Train]? = {
        guard let hasGame = self.game else {
            return nil
        }
        guard let hasBoard = hasGame.gameBoard else {
            return nil
        }
        let filtered = hasBoard.decks.sorted(by: { (t1: Train, t2: Train) -> Bool in
            return (t1.cost < t2.cost)
        })
        return filtered
    }()

    deinit {
        self.delegate = nil
    }

}

extension BuyTrainListViewModel
{


    func isTrainAvailableForPurchase(train: Train) -> Bool {
        if (train.isUnlocked) {
            print ("train is ok to purchase")
        }
        else {
            print ("train is NOT open for purchase")
        }
        return (train.isUnlocked)
    }

    func doesPlayerAlreadyOwnTrain(train: Train) -> Bool {

        guard let playerOnTurn = self.playerOnTurn else {
            return false
        }

        if (playerOnTurn.hand.containsTrain(train: train)) {
            return false
        }

        return true
    }

    func canPlayerAffordTrain(train: Train) -> Bool {
        guard let playerOnTurn = self.playerOnTurn else {
            return false
        }
        return (playerOnTurn.wallet.canAfford(amount: train.cost))
    }

    func hasRemainingStock(train: Train) -> Bool {
        return (TrainAPI.getRemainingStock(train: train) > 0)
    }
}


extension BuyTrainListViewModel
{

    func shouldPerformSegue(identifier: String) -> Bool {
        guard let hasGame = self.game else {
            assertionFailure("** No game object defined **")
            return false
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("** No game board defined **")
            return false
        }

        if (identifier == "trainDetailSegue") {
            guard let train = self.selectedTrain else {
                return false
            }
            if (!self.isTrainAvailableForPurchase(train: train)) {

                let title = NSLocalizedString("Not available for purchase", comment: "Not purchasable - Title")
                let body = NSLocalizedString("Train is not unlocked; try purchasing an earlier model", comment: "Not purchasable - Message")
                let message = Message(title: title, message: body)

                delegate?.showAlert(message: message)

                return false
            }
            if (!self.hasRemainingStock(train: train)) {
                let title = NSLocalizedString("No trains left for purchase", comment: "No trains left - Title")
                let body = NSLocalizedString("Train has no cards remaining", comment: "No trains left - Message")
                let message = Message(title: title, message: body)

                delegate?.showAlert(message: message)

                return false
            }
            if (!self.canPlayerAffordTrain(train: train)) {
                let title = NSLocalizedString("Not enough funds", comment: "Not enough funds - Title")
                let body = NSLocalizedString("Sorry, you cannot afford this train", comment: "Not enough funds - Message")
                let message = Message(title: title, message: body)

                delegate?.showAlert(message: message)

                return false
            }
            if (!self.doesPlayerAlreadyOwnTrain(train: train)) {
                let title = NSLocalizedString("Already own \(train.name)", comment: "Already own - Title")
                let body = NSLocalizedString("You already own this train", comment: "Already own - Message")
                let message = Message(title: title, message: body)

                delegate?.showAlert(message: message)

                return false
            }
        }

        return true
    }


}

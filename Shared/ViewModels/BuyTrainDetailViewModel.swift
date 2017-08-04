//
//  BuyTrainDetailViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 01/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class BuyTrainDetailViewModel : BaseViewModel
{
    var train: Train?

    public var buyTrainText : String? {
        guard let hasTrain = self.train else {
            return nil
        }

        let cost: NSNumber = NSNumber(integerLiteral: hasTrain.cost)
        guard let price = ObjectCache.currencyRateFormatter.string(from: cost) else {
            return nil
        }

        return NSLocalizedString("Buy train for \(price)", comment: "Buy train message")
    }

    lazy var rivals: [Player]? = {
        guard let hasGame = self.game else {
            return nil
        }
        guard let hasTrain = self.train else {
            return nil
        }
        guard let hasOwners = hasTrain.owners else {
            return nil
        }
        return hasOwners
    }()

    init(game: Game, train: Train) {
        super.init(game: game)

        self.train = train
    }

    func configureWithCell(cell: RivalTrainOwnersTableViewCell, atIndexPath: IndexPath)
    {
        guard let hasRivals = self.rivals else {
            return
        }
        guard let train = self.train else {
            return
        }

        let rival: Player = hasRivals[atIndexPath.row]
        print ("Rival: \(rival.description)")

        guard let card = (rival.hand.cards.filter { (card: LocomotiveCard) -> Bool in
            return (card.parent == train)
            }.first) else {
                return
        }
        guard let production = card.production else {
            return
        }

        cell.avatarImageView.image = UIImage(named: rival.asset)
        cell.unitsLabel.text = NSLocalizedString("\(production.units) units", comment: "Number of production units")
        cell.indexLabel.text = "# \(atIndexPath.row)"

        cell.layoutIfNeeded()
    }
}

//
//  BuyProductionDetailViewModel.swift
//  EngineYard
//
//  Created by Amarjit on 01/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import Foundation
import UIKit

class BuyProductionDetailViewModel : BaseViewModel
{
    var rivals: [Player]?
    var train: Train?

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

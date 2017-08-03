//
//  PlayerTaxView.swift
//  EngineYard
//
//  Created by Amarjit on 26/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class PlayerTaxView: UIView {

    @IBOutlet weak var headerBGView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet var taxLabelOutletCollection: [UILabel]!
    @IBOutlet weak var preTaxLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var taxDueAmountLabel: UILabel!


    func setup(player: Player) {

        guard let image = UIImage(named: player.asset) else {
            return
        }
        let balance: Int = player.wallet.balance
        let taxDue: Int = Tax.calculateTaxDue(onBalance: player.wallet.balance)
        let newBalance: Int = Int(balance - taxDue)

        let preTaxNumber = NSNumber(integerLiteral: balance)
        let taxDueNumber = NSNumber(integerLiteral: taxDue)
        let balanceNumber = NSNumber(integerLiteral: newBalance)

        guard let preTaxNumberFormatted = ObjectCache.currencyRateFormatter.string(from: preTaxNumber) else {
            return
        }
        guard let taxDueNumberFormatted = ObjectCache.currencyRateFormatter.string(from: taxDueNumber) else {
            return
        }
        guard let balanceNumberFormatted = ObjectCache.currencyRateFormatter.string(from: balanceNumber) else {
            return
        }

        self.avatarImageView.image = image.circled(forRadius: 70)

        self.preTaxLabel.text = preTaxNumberFormatted
        self.taxDueAmountLabel.text = taxDueNumberFormatted
        self.balanceLabel.text = balanceNumberFormatted

        let _ = self.taxLabelOutletCollection.map({
            $0.sizeToFit()
            $0.layoutIfNeeded()
        })
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

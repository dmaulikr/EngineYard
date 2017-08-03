//
//  PlayerTaxView.swift
//  EngineYard
//
//  Created by Amarjit on 26/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

public struct PlayerTaxViewModel
{
    public static var circleRadius: CGFloat = 70.0

    var beforeTax: Int = 0
    var taxDue: Int {
        if (self.beforeTax > 0) {
            return Tax.calculateTaxDue(onBalance: self.beforeTax)
        }
        return 0
    }
    var afterTax: Int {
        return (Int(self.beforeTax - taxDue))
    }

    lazy var formattedPreTaxBalance : String? = {
        let number = NSNumber(integerLiteral: self.beforeTax)
        guard let formatted = ObjectCache.currencyRateFormatter.string(from: number) else {
            return String(0)
        }
        return formatted
    }()

    lazy var formattedTaxDue : String = {
        let number = NSNumber(integerLiteral: self.taxDue)
        guard let formatted = ObjectCache.currencyRateFormatter.string(from: number) else {
            return String(0)
        }
        return formatted
    }()

    lazy var formattedBalance: String = {
        let number = NSNumber(integerLiteral: self.afterTax)
        guard let formatted = ObjectCache.currencyRateFormatter.string(from: number) else {
            return String(0)
        }
        return formatted
    }()


    init(amount: Int) {
        self.beforeTax = amount
    }
}

class PlayerTaxView: UIView {

    @IBOutlet weak var headerBGView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet var taxLabelOutletCollection: [UILabel]!

    @IBOutlet weak var preTaxLabel: UILabel!
    @IBOutlet weak var taxDueLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!


    func setup(player: Player) {

        guard let image = UIImage(named: player.asset) else {
            return
        }

        var taxViewModel: PlayerTaxViewModel = PlayerTaxViewModel(amount: player.wallet.balance)

        self.avatarImageView.image = image.circled(forRadius: PlayerTaxViewModel.circleRadius)
        self.avatarImageView.layoutIfNeeded()

        self.preTaxLabel.text = taxViewModel.formattedPreTaxBalance
        self.taxDueLabel.text = taxViewModel.formattedTaxDue
        self.balanceLabel.text = taxViewModel.formattedBalance

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

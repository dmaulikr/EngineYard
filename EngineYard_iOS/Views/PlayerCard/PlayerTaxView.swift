//
//  PlayerTaxView.swift
//  EngineYard
//
//  Created by Amarjit on 26/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

fileprivate struct PlayerTaxViewModel
{
    public static var circleRadius: CGFloat = 70.0

    public private(set) var preTaxBalance: Int = 0 {
        didSet {
            self.taxDue = Tax.calculateTaxDue(onBalance: self.preTaxBalance)
        }
    }
    public private(set) var taxDue: Int = 0
    public var balance: Int {
        return Int(self.preTaxBalance - taxDue)
    }

    lazy var formattedPreTaxBalance : String? = {
        let number = NSNumber(integerLiteral: self.preTaxBalance)
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
        let number = NSNumber(integerLiteral: self.balance)
        guard let formatted = ObjectCache.currencyRateFormatter.string(from: number) else {
            return String(0)
        }
        return formatted
    }()

    init(player: Player) {
        self.preTaxBalance = player.wallet.balance
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

        var taxViewModel: PlayerTaxViewModel = PlayerTaxViewModel(player: player)

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

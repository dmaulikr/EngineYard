//
//  EYEngineCardView.swift
//  EngineYard
//
//  Created by Amarjit on 14/03/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class EngineCardView: UIView {

    @IBOutlet weak var trainNameLabel: UILabel!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet var iconCollection: [UIImageView]!
    @IBOutlet weak var purchaseCostLabel: UILabel!
    @IBOutlet weak var productionCostLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var ordersTitleLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var diceCollection: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        for iconIV in self.iconCollection {
            iconIV.image = iconIV.image?.maskWithColor(color: .white)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


    func setup(loco: Locomotive) {
        let genNumber = NSNumber(integerLiteral: loco.generation.rawValue)
        let costNumber = NSNumber(integerLiteral: loco.cost)
        let productionNumber = NSNumber(integerLiteral: loco.productionCost)
        let incomeNumber = NSNumber(integerLiteral: loco.income)
        let qtyNumber = NSNumber(integerLiteral: loco.engines.count)

        self.headerView.backgroundColor = loco.engineColor.getColorForEngine()

        self.trainNameLabel.text = loco.name
        self.generationLabel.text = NSLocalizedString("Generation \(genNumber)", comment: "Generation number")
        self.purchaseCostLabel.text = ObjectCache.currencyRateFormatter.string(from: costNumber)
        self.productionCostLabel.text = ObjectCache.currencyRateFormatter.string(from: productionNumber)
        self.incomeLabel.text = ObjectCache.currencyRateFormatter.string(from: incomeNumber)

        self.trainNameLabel.sizeToFit()
        self.generationLabel.sizeToFit()
        self.purchaseCostLabel.sizeToFit()
        self.productionCostLabel.sizeToFit()
        self.incomeLabel.sizeToFit()

        self.ordersTitleLabel.text = NSLocalizedString("Orders", comment: "Orders title")
        self.qtyLabel.text = NSLocalizedString("\(qtyNumber) / \(qtyNumber) Remaining", comment: "Qty of cards remaining in stock")
        self.qtyLabel.sizeToFit()

        for imgView:UIImageView in diceCollection {
            imgView.isHidden = true
        }

        /**
        if (loco.orders.count > 0)
        {
            for (index, dp) in loco.orders.enumerated() {
                let dieValue:Int = dp.d6
                let asset = Die.imageNameForValue(dieValue: dieValue)
                diceCollection[index].image = UIImage(named: asset)
                diceCollection[index].isHidden = false
            }
        }
        **/
    }

    override func updateConstraints() {
        super.updateConstraints()
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }

}

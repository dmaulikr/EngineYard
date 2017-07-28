//
//  EYEngineCardView.swift
//  EngineYard
//
//  Created by Amarjit on 14/03/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class EngineCardView: UIView {

    @IBOutlet var iconsOutletCollection: [UIImageView]!
    @IBOutlet var labelOutletCollection: [UILabel]!
    @IBOutlet var diceOutletCollection: [UIImageView]!
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var productionCostLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!
    @IBOutlet weak var orderLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var checkMark: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
        if (self.iconsOutletCollection.count >  0)
        {
            for iconIV in self.iconsOutletCollection {
                iconIV.image = iconIV.image?.maskWithColor(color: .white)
            }
        }
        self.checkMark.image = self.checkMark.image?.maskWithColor(color: .green)
    }

    override func updateConstraints() {
        super.updateConstraints()
    }

    func setup(loco: Locomotive) {
        let genNumber = NSNumber(integerLiteral: loco.generation.rawValue)
        let costNumber = NSNumber(integerLiteral: loco.cost)
        let productionNumber = NSNumber(integerLiteral: loco.productionCost)
        let incomeNumber = NSNumber(integerLiteral: loco.income)
        let childrenNumber = NSNumber(integerLiteral: loco.numberOfChildren)

        self.nameLabel.text = loco.name
        self.generationLabel.text = NSLocalizedString("Generation \(genNumber)", comment: "Train generation number")
        self.costLabel.text = ObjectCache.currencyRateFormatter.string(from: costNumber)
        self.productionCostLabel.text = ObjectCache.currencyRateFormatter.string(from: productionNumber)
        self.incomeLabel.text = ObjectCache.currencyRateFormatter.string(from: incomeNumber)
        self.numberOfChildrenLabel.text = NSLocalizedString("\(childrenNumber) / \(childrenNumber)", comment: "Number of child Engines remaining in stock")

        for label in labelOutletCollection {
            label.sizeToFit()
            label.layoutIfNeeded()
        }

        self.orderLabel.text = NSLocalizedString("Orders", comment: "Orders title")

        for imgView:UIImageView in self.diceOutletCollection {
            imgView.isHidden = true
        }

        if (loco.existingOrders.count > 0)
        {
            for (index, orderValue) in loco.existingOrders.enumerated() {
                let asset = Die.assetNameForValue(dieValue: orderValue)

                guard let item = (self.diceOutletCollection.filter({ (imgView) -> Bool in
                    return (imgView.tag == index)
                }).first) else {
                    return
                }
                item.image = UIImage(named: asset)
                item.isHidden = false

                /*
                self.diceOutletCollection[index].image = UIImage(named: asset)
                self.diceOutletCollection[index].isHidden = false
                 */
            }
        }

        self.checkMark.isHidden = true

        self.setHeaderColor(loco: loco)
    }

    func setHeaderColor(loco: Locomotive) {
        switch loco.engineColor {
        case .green:
            self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 66/255, green: 230/255, blue: 149/255, alpha: 1)
            break
        case .red:
            self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 245/255, green: 78/255, blue: 162/255, alpha: 1)
            break
        case .yellow:
            self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 252/255, green: 227/255, blue: 138/255, alpha: 1)
            break
        case .blue:
            self.headerView.backgroundColor = UIColor.init(colorLiteralRed: 23/255, green: 234/255, blue: 217/255, alpha: 1)
            break
        }
    }

    public static func applyDropShadow(loco: Locomotive, toView: UIView) {
        
        let alpha: Float = 1.0
        var color = UIColor.init(colorLiteralRed: 192/255, green: 192/255, blue: 192/255, alpha: alpha)

        switch loco.engineColor {
        case .green:
            color = UIColor.init(colorLiteralRed: 59/255, green: 178/255, blue: 184/255, alpha: alpha)
            break
        case .red:
            color = UIColor.init(colorLiteralRed: 255/255, green: 118/255, blue: 118/255, alpha: alpha)
            break
        case .yellow:
            color = UIColor.init(colorLiteralRed: 243/255, green: 129/255, blue: 129/255, alpha: alpha)
            break
        case .blue:
            color = UIColor.init(colorLiteralRed: 96/255, green: 120/255, blue: 234/255, alpha: alpha)
            break
        }

        toView.layer.masksToBounds = false
        toView.layer.shadowColor = color.cgColor
        toView.layer.shadowOpacity = 0.25
        toView.layer.shadowOffset = CGSize(width: 5, height: 5)
        toView.layer.shadowRadius = 5
        toView.layer.shadowPath = UIBezierPath(rect: toView.bounds).cgPath
        toView.layer.shouldRasterize = true
        toView.layer.rasterizationScale = UIScreen.main.scale
    }


//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        super.draw(rect)
//    }

}

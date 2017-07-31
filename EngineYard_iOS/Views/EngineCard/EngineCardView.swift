 //
//  EYEngineCardView.swift
//  EngineYard
//
//  Created by Amarjit on 14/03/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

struct Card : TrainProtocol
{
    let name: String
    let cost: Int
    let productionCost: Int
    let income: Int
    let generation: Generation
    let engineColor: EngineColor
    let isUnlocked: Bool
    let capacity: Int
    let numberOfChildren: Int
    var isRusting: Bool
    var hasRusted: Bool
    var existingOrderValues: [Int]
    var owners: [Player]?

    init(with train: Train) {
        self.name = train.name
        self.cost = train.cost
        self.productionCost = train.productionCost
        self.income = train.cost
        self.generation = train.generation
        self.engineColor = train.engineColor
        self.isUnlocked = train.isUnlocked
        self.capacity = train.capacity
        self.numberOfChildren = train.capacity
        self.isRusting = train.isRusting
        self.hasRusted = train.hasRusted
        self.existingOrderValues = train.existingOrderValues
        self.owners = train.owners
    }
}

class EngineCardView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func updateConstraints() {
        super.updateConstraints()
    }

    override func updateConstraintsIfNeeded() {
        super.updateConstraintsIfNeeded()
    }

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
    @IBOutlet weak var checkmark: UIImageView!

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
        self.checkmark.image = self.checkmark.image?.maskWithColor(color: .green)
    }

    func setup(card: Card) {

        let genNumber = NSNumber(integerLiteral: card.generation.rawValue)
        let costNumber = NSNumber(integerLiteral: card.cost)
        let productionNumber = NSNumber(integerLiteral: card.productionCost)
        let incomeNumber = NSNumber(integerLiteral: card.income)

        let ownersCount = card.owners?.count ?? 0
        let cardsLeft = (card.numberOfChildren - ownersCount)
        let remainingStockNumber = NSNumber(integerLiteral: cardsLeft)

        self.nameLabel.text = card.name
        self.generationLabel.text = NSLocalizedString("Generation \(genNumber)", comment: "Train generation number")
        self.costLabel.text = ObjectCache.currencyRateFormatter.string(from: costNumber)
        self.productionCostLabel.text = ObjectCache.currencyRateFormatter.string(from: productionNumber)
        self.incomeLabel.text = ObjectCache.currencyRateFormatter.string(from: incomeNumber)
        self.numberOfChildrenLabel.text = NSLocalizedString("\(remainingStockNumber) left", comment: "Number of cards left in stock")

        self.orderLabel.text = NSLocalizedString("Orders", comment: "Orders title")
        self.checkmark.isHidden = true

        let _ = self.diceOutletCollection.map({
            $0.isHidden = true
        })

        let _ = self.labelOutletCollection.map({
            $0.sizeToFit()
            $0.layoutIfNeeded()
        })

        self.applyHeaderColor(card: card)
    }

    func applyHeaderColor(card: Card) {

        switch card.engineColor {
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

    func applyDropShadow(card: Card, forView: UIView) {
        let alpha: Float = 1.0
        var color = UIColor.init(colorLiteralRed: 192/255, green: 192/255, blue: 192/255, alpha: alpha)

        switch card.engineColor {
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

        forView.layer.masksToBounds = false
        forView.layer.shadowColor = color.cgColor
        forView.layer.shadowOpacity = 0.25
        forView.layer.shadowOffset = CGSize(width: 5, height: 5)
        forView.layer.shadowRadius = 5
        forView.layer.shadowPath = UIBezierPath(rect: forView.bounds).cgPath
        forView.layer.shouldRasterize = true
        forView.layer.rasterizationScale = UIScreen.main.scale
    }

//    // Only override draw() if you perform custom drawing.
//    // An empty implementation adversely affects performance during animation.
//    override func draw(_ rect: CGRect) {
//        // Drawing code
//        super.draw(rect)
//    }

}

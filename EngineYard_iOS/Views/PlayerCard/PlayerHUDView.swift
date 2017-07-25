//
//  PlayerHUDView.swift
//  EngineYard
//
//  Created by Amarjit on 29/03/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class PlayerHUDView: UIView {

    @IBOutlet weak var cashLbl: UILabel!
    @IBOutlet weak var trainsCountLbl: UILabel!
    @IBOutlet weak var avtButton: UIButton!
    @IBOutlet var iconCollection: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
        if let btn = self.avtButton {
            btn.layer.cornerRadius = 5.0
            btn.layer.masksToBounds = true
        }
        self.layoutIfNeeded()
    }

    func updatePlayerHUD(player: Player) {
        let cashNumber = NSNumber(integerLiteral: player.cash)
        self.cashLbl.text = ObjectCache.currencyRateFormatter.string(from: cashNumber)
        self.cashLbl.sizeToFit()

        if (player.asset != "") {
            let image = UIImage(named: player.asset)
            self.avtButton.setImage(image, for: .normal)
        }

        self.trainsCountLbl.text = String(0)
    }

    // MARK: - IBActions

    @IBAction func avtBtnPressed(_ sender: Any) {
        print("Pressed")
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

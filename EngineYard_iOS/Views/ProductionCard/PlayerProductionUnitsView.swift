//
//  EYPlayerProductionUnitsView.swift
//  EngineYard
//
//  Created by Amarjit on 02/04/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class PlayerProductionUnitsView: UIView {

    @IBOutlet weak var productionUnitsLbl: UILabel!
    @IBOutlet weak var avtButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        if let btn = self.avtButton {
            btn.layer.cornerRadius = 5.0
            btn.layer.masksToBounds = true
        }
        self.layoutIfNeeded()
    }

    func updatePlayerHUD(player: Player, engine: Engine) {
        if (player.asset != "") {
            let image = UIImage(named: player.asset)
            self.avtButton.setImage(image, for: .normal)
        }

        self.productionUnitsLbl.text = String(engine.units)
    }

    // MARK: - IBActions

    @IBAction func avtBtnPressed(_ sender: Any) {
        print("Pressed")
    }
    
}

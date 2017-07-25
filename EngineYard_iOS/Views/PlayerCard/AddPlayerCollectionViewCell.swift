//
//  EYAddPlayerCollectionViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 23/03/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class AddPlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerBtn: UIButton!
    @IBOutlet weak var isAISwitch: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.playerBtn.layer.cornerRadius = 5.0
        self.playerBtn.layer.masksToBounds = true
        self.playerBtn.layer.shadowColor = UIColor.darkGray.cgColor
        self.isAISwitch.isUserInteractionEnabled = false // #TODO - Handle AI/Player switch states
        self.layoutIfNeeded()
    }

    @IBAction func playerBtnPressed(_ sender:UIButton) {
        
    }

    @IBAction func isAISwitchPressed(_ sender:UIButton) {
        self.isAISwitch.isSelected = !self.isAISwitch.isSelected
    }

}

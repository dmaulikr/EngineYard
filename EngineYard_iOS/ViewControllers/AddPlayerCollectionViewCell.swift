//
//  AddPlayerCollectionViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 01/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class AddPlayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avtBtn: UIButton!
    @IBOutlet weak var aiSwitchBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.avtBtn.layer.cornerRadius = 8.0
        self.avtBtn.layer.masksToBounds = true
    }

    @IBAction func avtBtnPressed(_ sender: UIButton) {

    }

    @IBAction func toggleAISwitch(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    


}

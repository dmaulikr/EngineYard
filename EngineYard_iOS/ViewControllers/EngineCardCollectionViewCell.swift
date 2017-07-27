//
//  EngineCardCollectionViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 27/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class EngineCardCollectionViewCell: UICollectionViewCell {

    static var cellReuseIdentifier = "EngineCardCollectionViewCell"
    weak var engineCardView: EngineCardView?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        self.backgroundColor = UIColor.white
    }

}


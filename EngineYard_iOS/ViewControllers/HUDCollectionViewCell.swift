//
//  EYHUDCollectionViewCell.swift
//  EngineYard
//
//  Created by Amarjit on 04/04/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class HUDCollectionViewCell: UICollectionViewCell {

    static var cellReuseIdentifer = "HUDCellReuseID"

    override func prepareForReuse() {
        super.prepareForReuse()

        for subview in self.contentView.subviews {
            if (subview.isKind(of: UIView.self)) {
                subview.removeFromSuperview()
            }
        }
    }

}



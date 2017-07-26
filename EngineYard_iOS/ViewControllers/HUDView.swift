//
//  HUDView.swift
//  EngineYard
//
//  Created by Amarjit on 26/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

@IBDesignable class HUDView: UIView, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.collectionView.register(HUDCollectionViewCell.self, forCellWithReuseIdentifier:HUDCollectionViewCell.cellReuseIdentifer)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HUDCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HUDCollectionViewCell.cellReuseIdentifer, for: indexPath) as! HUDCollectionViewCell

        let arr = UINib(nibName: "PlayerHUDView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerHUDView
        cell.contentView.addSubview(view)        

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath)
    }

    // MARK: - IBActions

    @IBAction func menuBtnPressed(_ sender: UIButton) {
        print ("pressed menuBtn")
    }


}

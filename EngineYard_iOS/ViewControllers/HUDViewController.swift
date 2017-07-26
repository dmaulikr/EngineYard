//
//  HUDViewController.swift
//  EngineYard
//
//  Created by Amarjit on 26/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import SVProgressHUD
import QuartzCore

class HUDViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(HUDCollectionViewCell.self, forCellWithReuseIdentifier: HUDCollectionViewCell.cellReuseIdentifer)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }


    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HUDCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HUDCollectionViewCell.cellReuseIdentifer, for: indexPath) as! HUDCollectionViewCell

        /*
        let arr = UINib(nibName: "EYPlayerHUDView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! EYPlayerHUDView
        cell.contentView.addSubview(view)

        if let allPlayers = self.allPlayers
        {
            let player:EYPlayer = allPlayers[indexPath.row]
            view.updatePlayerHUD(player: player)
        }

        if (gameModel.turnOrderManager.turnOrderIndex == indexPath.row) {
            let border = CALayer()
            border.backgroundColor = UIColor(colorLiteralRed: 23/255, green: 234/255, blue: 217/255, alpha: 0.75).cgColor
            let width = CGFloat(2.0)
            border.frame = CGRect(x: 0, y: cell.frame.size.height + 5 - width, width: cell.frame.size.width - 10, height: width)
            cell.layer.addSublayer(border)
        }
        */

        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath)
    }

    // MARK: - IBActions

    @IBAction func menuBtnPressed(_ sender:UIButton) {
        print ("Pressed")
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

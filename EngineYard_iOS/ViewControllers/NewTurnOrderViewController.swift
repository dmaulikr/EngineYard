//
//  NewTurnOrderViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import GSMessages

class NewTurnOrderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    var turnOrderViewModel: NewTurnOrderViewModel!

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var turnOrderCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.turnOrderCollectionView.delegate = self
        self.turnOrderCollectionView.dataSource = self
        self.turnOrderCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NewTurnOrderViewModel.cellReuseIdentifier)
        self.turnOrderCollectionView.backgroundColor = UIColor.clear
        self.turnOrderCollectionView.delegate = self
        self.turnOrderCollectionView.dataSource = self
        self.turnOrderCollectionView.allowsMultipleSelection = false
        self.turnOrderCollectionView.allowsSelection = false
        self.turnOrderCollectionView.layoutIfNeeded()
        self.turnOrderCollectionView.reloadData()
        self.view.layoutIfNeeded()

        let message = NSLocalizedString("This is the new turn order", comment: "New turn order")
        showMessage(message, type: .info)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let gameObj = self.turnOrderViewModel.game else {
            return 0
        }
        return gameObj.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewTurnOrderViewModel.cellReuseIdentifier, for: indexPath) as UICollectionViewCell

        let arr = UINib(nibName: "PlayerWinnerView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerWinnerView
        cell.contentView.addSubview(view)

        if let _ = self.turnOrderViewModel.game {

            if let playersSortedByLowestCash = self.turnOrderViewModel.playersSortedByLowestCash {

                let player = playersSortedByLowestCash[indexPath.row]
                view.avatarImageView?.image = UIImage(named: player.asset)
                view.indexLabel?.text = "#\(indexPath.row+1)"
                view.cashLabel?.text = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: player.cash))
                view.nameLabel?.text = player.name
            }

        }

        view.layoutIfNeeded()
        cell.setNeedsLayout()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
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

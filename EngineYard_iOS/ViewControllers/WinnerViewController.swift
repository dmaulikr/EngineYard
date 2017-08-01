//
//  WinnerViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak private var winnerCollectionView: UICollectionView!
    @IBOutlet var menuBtnOutletCollection: [UIButton]!
    @IBOutlet weak var pageTitleLabel: UILabel!

    var winnerViewModel: WinnerViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageTitleLabel.text = WinnerViewModel.pageTitleText
        self.winnerCollectionView.allowsSelection = false
        self.winnerCollectionView.allowsMultipleSelection = false
        self.winnerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "winnerCellReuseID")
        self.winnerCollectionView.dataSource = self
        self.winnerCollectionView.delegate = self
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - CollectionView delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game = self.winnerViewModel.game else {
            return 0
        }
        return game.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winnerCellReuseID", for: indexPath) as UICollectionViewCell

        guard let players = self.winnerViewModel.players else {
            return cell
        }

        let player = players[indexPath.row]

        let arr = UINib(nibName: "PlayerOblongView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerOblongView
        cell.contentView.addSubview(view)

        view.avatarImageView?.image = UIImage(named: player.asset)
        view.indexLabel?.text = "#\(indexPath.row+1)"
        view.cashLabel?.text = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: player.cash))
        view.nameLabel?.text = player.name

        view.layoutIfNeeded()


        cell.setNeedsLayout()
        
        return cell
    }

    // MARK: - IBActions

    @IBAction func menuBtnPressed(_ sender: UIButton) {
        
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

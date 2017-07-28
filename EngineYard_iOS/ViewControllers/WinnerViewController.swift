//
//  WinnerViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import GSMessages

class WinnerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var winnerCollectionView: UICollectionView!
    @IBOutlet var menuBtnOutletCollection: [UIButton]!
    @IBOutlet weak var pageTitleLabel: UILabel!

    var winnerViewModel : WinnerViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageTitleLabel.text = WinnerViewModel.pageTitleText
        self.winnerCollectionView.allowsSelection = false
        self.winnerCollectionView.allowsMultipleSelection = false
        self.winnerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "winnerCellReuseID")
        self.winnerCollectionView.dataSource = self
        self.winnerCollectionView.delegate = self
        self.view.layoutIfNeeded()

        self.setupWinnerMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupWinnerMessage() {
        guard let viewModel = self.winnerViewModel else {
            return
        }

        guard let winners = viewModel.playersSortedByHighestCash else {
            return
        }

        guard let winner = winners.first else {
            return
        }

        let cashNumber = NSNumber(integerLiteral: winner.account.balance)
        let cashString = ObjectCache.currencyRateFormatter.string(from: cashNumber)
        let message = NSLocalizedString("\(winner.name) is the winner with \(cashString)", comment: "Winner declared!")
        showMessage(message, type: .success)
    }

    // MARK: - IBActions

    @IBAction func menuBtnPressed(_ sender: UIButton) {

    }

    // MARK: - CollectionView delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let gameObj = self.winnerViewModel.game else {
            return 0
        }
        return gameObj.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winnerCellReuseID", for: indexPath) as UICollectionViewCell

        let arr = UINib(nibName: "PlayerWinnerView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerWinnerView
        cell.contentView.addSubview(view)

        if let _ = self.winnerViewModel.game {
            if let playersSortedByHighestCash = self.winnerViewModel.playersSortedByHighestCash {
                let player: Player = playersSortedByHighestCash[indexPath.row]

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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

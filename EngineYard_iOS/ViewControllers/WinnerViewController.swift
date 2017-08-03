//
//  WinnerViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import GSMessages

class WinnerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak private var winnerCollectionView: UICollectionView!
    @IBOutlet var menuBtnOutletCollection: [UIButton]!
    @IBOutlet weak var pageTitleLabel: UILabel!

    var viewModel: WinnerViewModel?

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.displayWinnerMessage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func displayWinnerMessage() {
        guard let hasViewModel = self.viewModel else {
            return
        }

        guard let winners = hasViewModel.playersSortedByHighestCash else {
            return
        }

        guard let winner = winners.first else {
            return
        }

        let cashNumber = NSNumber(integerLiteral: winner.wallet.balance)
        let cashString = ObjectCache.currencyRateFormatter.string(from: cashNumber)!
        let message = NSLocalizedString("\(winner.name) is the winner with \(cashString)", comment: "Winner declared!")

        //showMessage(message, type: .success)

        self.showMessage(message, type: .success, options: [
            .animation(.slide),
            .animationDuration(0.5),
            .autoHide(true),
            .autoHideDelay(10.0),
            .height(44.0),
            .hideOnTap(true),
            .position(.top),
            .textAlignment(.center),
            .textColor(UIColor.white),
            .textNumberOfLines(1),
            .textPadding(30.0)
            ])
    }



    // MARK: - CollectionView delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game = self.viewModel?.game else {
            return 0
        }
        return game.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winnerCellReuseID", for: indexPath) as UICollectionViewCell

        guard let players = self.viewModel?.players else {
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

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

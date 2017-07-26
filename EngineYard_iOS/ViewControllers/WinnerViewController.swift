//
//  WinnerViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class WinnerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var winnerCollectionView: UICollectionView!
    @IBOutlet var menuBtnOutletCollection: [UIButton]!
    @IBOutlet weak var pageTitleLabel: UILabel!

    var viewModel : WinnerViewModel = WinnerViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageTitleLabel.text = WinnerViewModel.pageTitleText
        self.winnerCollectionView.allowsSelection = false
        self.winnerCollectionView.allowsMultipleSelection = false
        self.winnerCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "winnerCellReuseID")
        self.winnerCollectionView.dataSource = self
        self.winnerCollectionView.delegate = self
        self.view.layoutIfNeeded()

        print ("GameObj: \(self.viewModel.game?.description)")

        let message = "Winner is declared!"

        let alert = UIAlertController(title: "Winner", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (alertAction:UIAlertAction) in
        }
        alert.addAction(ok)

        //self.present(alertController, animated: true, completion: nil)
        self.present(alert, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions

    @IBAction func menuBtnPressed(_ sender: UIButton) {

    }

    // MARK: - CollectionView delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.game.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winnerCellReuseID", for: indexPath) as UICollectionViewCell

        let arr = UINib(nibName: "PlayerWinnerView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerWinnerView
        cell.contentView.addSubview(view)

        if let _ = self.viewModel.game {
            let player: Player = self.viewModel.playersSortedByCash[indexPath.row]
            view.avatarImageView?.image = UIImage(named: player.asset)
            view.indexLabel?.text = "#\(indexPath.row+1)"
            view.cashLabel?.text = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: player.cash))
            view.nameLabel?.text = player.name
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

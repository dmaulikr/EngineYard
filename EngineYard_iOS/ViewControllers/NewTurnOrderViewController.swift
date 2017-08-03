//
//  NewTurnOrderViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class NewTurnOrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak private var turnOrderCollectionView: UICollectionView!

    var viewModel: NewTurnOrderViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.turnOrderCollectionView.allowsSelection = false
        self.turnOrderCollectionView.allowsMultipleSelection = false
        self.turnOrderCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "turnOrderCellReuseID")
        self.turnOrderCollectionView.dataSource = self
        self.turnOrderCollectionView.delegate = self

        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - CollectionView delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game = self.viewModel?.game else {
            return 0
        }
        return game.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "turnOrderCellReuseID", for: indexPath) as UICollectionViewCell

        guard let viewModel = self.viewModel else {
            return cell
        }

        if let player = viewModel.game?.players[indexPath.row]
        {
            let arr = UINib(nibName: "PlayerOblongView", bundle: nil).instantiate(withOwner: nil, options: nil)
            let view = arr[0] as! PlayerOblongView
            cell.contentView.addSubview(view)

            view.avatarImageView?.image = UIImage(named: player.asset)
            view.indexLabel?.text = "#\(indexPath.row+1)"
            view.cashLabel?.text = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: player.cash))
            view.nameLabel?.text = player.name
            
            view.layoutIfNeeded()
        }

        cell.setNeedsLayout()

        return cell
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "buyTrainSegue", sender: self)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        guard let hasGame = self.viewModel?.game else {
            assertionFailure("** No game object defined **")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("** No game board defined **")
            return
        }

        if (segue.identifier == "buyTrainSegue") {

            let vc : BuyTrainListViewController = (segue.destination as? BuyTrainListViewController)!
            vc.viewModel = BuyTrainListViewModel.init(game: hasGame)
        }
    }


}

//
//  TaxesViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class TaxesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var taxCollectionView: UICollectionView!

    var taxViewModel: TaxesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.taxCollectionView.delegate = self
        self.taxCollectionView.dataSource = self
        self.taxCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TaxCollectionViewCellReuseID")
        self.taxCollectionView.backgroundColor = UIColor.clear
        self.taxCollectionView.delegate = self
        self.taxCollectionView.dataSource = self
        self.taxCollectionView.allowsMultipleSelection = false
        self.taxCollectionView.allowsSelection = false
        self.taxCollectionView.layoutIfNeeded()
        self.taxCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.taxViewModel.game.players.count
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaxCollectionViewCellReuseID", for: indexPath) as UICollectionViewCell


        let arr = UINib(nibName: "PlayerTaxView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerTaxView
        cell.contentView.addSubview(view)


       // if let game = self.taxViewModel.game {
        if let game = self.taxViewModel.game {
            let player: Player = game.players[indexPath.row]

            let balanceText = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: player.cash))
            let taxDueText = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: player.cash))
            let preTaxText = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: player.cash))

            view.avatarImageView?.image = UIImage(named: player.asset)
            view.preTaxLabel.text = preTaxText
            view.taxDueAmountLabel.text = taxDueText
            view.balanceLabel.text = balanceText
       }

        view.layoutIfNeeded()
        cell.setNeedsLayout()
        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

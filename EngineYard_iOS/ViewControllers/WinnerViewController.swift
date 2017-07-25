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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var menuBtnOutletCollection: [UIButton]!
    @IBOutlet weak var pageTitle: UILabel!

    var viewModel : WinnerViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pageTitle.text = WinnerViewModel.pageTitleText
        self.collectionView.allowsSelection = false
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "winnerCellReuseID")
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions

    @IBAction func menuBtnPressed(_ sender: UIButton) {

    }

    // MARK: - CollectionView delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "winnerCellReuseID", for: indexPath) as UICollectionViewCell

        let arr = UINib(nibName: "PlayerWinnerView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerWinnerView
        cell.contentView.addSubview(view)

        /*
        let player:Player = self.playerList[indexPath.row]
        view.avatarImageView.image = UIImage(named: player.asset)
        view.positionLbl.text = "#\(indexPath.row+1)"
        view.cashLbl.text = ObjectCache.currencyRateFormatter.string(from: NSNumber(integerLiteral: player.cash))
        view.nameLbl.text = player.name
        */

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

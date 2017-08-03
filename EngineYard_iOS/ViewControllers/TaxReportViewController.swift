//
//  TaxReportViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class TaxReportViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var viewModel: TaxReportViewModel?
    @IBOutlet weak var taxCollectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let hasGame = self.viewModel?.game else {
            return 0
        }
        return hasGame.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaxCellReuseID", for: indexPath)

        if let hasGame = self.viewModel?.game
        {
            let arr = UINib(nibName: "PlayerTaxView", bundle: nil).instantiate(withOwner: nil, options: nil)
            let view = arr[0] as! PlayerTaxView

            let player = hasGame.players[indexPath.row]
            view.setup(player: player)

            cell.contentView.addSubview(view)
            cell.layoutIfNeeded()
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {

        // Apply tax to players before continuing
        guard let hasViewModel = self.viewModel else {
            assertionFailure("** No view model defined in \(#file) \(#function)**")
            return
        }

        hasViewModel.applyTaxes { (completed) in
            if (completed) {

                waitFor(duration: 0.75, callback: { (completed) in
                    if (completed) {
                        let identifier = "marketDemandsSegue"
                        if (self.shouldPerformSegue(withIdentifier: identifier, sender: self)) {
                            self.performSegue(withIdentifier: identifier, sender: self)
                        }
                    }
                })
            }
        }
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        guard let hasViewModel = self.viewModel else {
            return false
        }
        guard let hasGame = hasViewModel.game else {
            return false
        }
        guard let _ = hasGame.gameBoard else {
            return false
        }

        return true
    }

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

        if (segue.identifier == "winnerSegue") {

        }
        if (segue.identifier == "marketDemandsSegue") {

            let vc : MarketDemandsViewController = (segue.destination as? MarketDemandsViewController)!
            vc.viewModel = MarketDemandsViewModel.init(game: hasGame)
        }

    }


}

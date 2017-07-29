//
//  ListTrainsForPurchaseVC.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import GSMessages

class ListTrainsForPurchaseVC: UIViewController
{
    var trainsListViewModel: PurchaseableTrainsViewModel?
    weak var trainViewController: TrainViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add child view controller
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func endTurnBtnPressed(_ sender: UIButton) {

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        guard let hasGame = self.trainsListViewModel?.game else {
            assertionFailure("No game object defined")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("No gameboard defined")
            return
        }

        if (segue.identifier == "productionSegue") {
            let vc : BuyProductionViewController = (segue.destination as? BuyProductionViewController)!
            vc.productionPageViewModel = ProductionPageViewModel.init(game: hasGame)
        }

    }
}

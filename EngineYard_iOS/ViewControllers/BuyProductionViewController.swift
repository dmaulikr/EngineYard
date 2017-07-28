//
//  BuyProductionViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class BuyProductionViewController: UIViewController {

    var productionPageViewModel: ProductionPageViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        guard let hasGame = self.productionPageViewModel?.game else {
            assertionFailure("No game object defined")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("No gameboard defined")
            return
        }

        if (segue.identifier == "sellingSegue") {
            let vc : SellingViewController = (segue.destination as? SellingViewController)!
            vc.sellingViewModel = SellingViewModel.init(game: hasGame)        
        }

    }


}

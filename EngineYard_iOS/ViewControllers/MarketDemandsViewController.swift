//
//  MarketDemandsViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class MarketDemandsViewController: UIViewController {

    var viewModel: MarketDemandsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newTurnOrderSegue", sender: self)
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

        let identifier = "newTurnOrderSegue"
        if (self.shouldPerformSegue(withIdentifier: identifier, sender: self))
        {
            self.performSegue(withIdentifier: identifier, sender: self)
        }
        
        return false
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        guard let hasGame = self.viewModel?.game else {
            return
        }
        guard let _ = hasGame.gameBoard else {
            return
        }

        if (segue.identifier == "newTurnOrderSegue") {

            let vc : NewTurnOrderViewController = (segue.destination as? NewTurnOrderViewController)!
            vc.viewModel = NewTurnOrderViewModel.init(game: hasGame)
        }

    }


}

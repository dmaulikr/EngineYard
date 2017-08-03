//
//  TaxReportViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class TaxReportViewController: UIViewController {

    var viewModel: TaxReportViewModel?

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
        self.performSegue(withIdentifier: "marketDemandsSegue", sender: self)
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
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

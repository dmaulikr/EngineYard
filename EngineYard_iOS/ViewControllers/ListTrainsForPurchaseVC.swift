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
        self.addTrainViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        guard let hasChildController = self.trainViewController else {
            return
        }
        hasChildController.removeFromParentViewController()
    }

    private func addTrainViewController() {

        // Launch Train View Controller
        let sb: UIStoryboard = UIStoryboard(name: "Trains", bundle: nil)
        if let controller = sb.instantiateViewController(withIdentifier: "TrainViewController") as? TrainViewController
        {
            self.trainViewController = controller

            addChildViewController(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(controller.view)

            NSLayoutConstraint.activate([
                controller.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                controller.view.topAnchor.constraint(equalTo: self.view.topAnchor),
                controller.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                ])

            controller.didMove(toParentViewController: self)

            controller.doneClosure = { (doneBtnPressed: Bool) in
                // end turn, handle whether to move to next page
                if (doneBtnPressed) {
                    print ("doneBtn pressed")
                }
            }
            controller.selectedTrainClosure = { (train: Locomotive?) in
                print ("selectedTrainClosure pressed")
                if let selectedTrain = train {
                    print ("You clicked on: \(selectedTrain.name)")
                    //hasViewModel.selectedTrain = selectedTrain
                    //self.performSegue(withIdentifier: "trainDetailSegue", sender: self)
                }
            }
        }
    }


    // MARK: - IBAction

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

//
//  BuyTrainViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class BuyTrainViewController: UIViewController {

    var buyTrainViewModel: BuyTrainViewModel?
    weak var controller: TrainViewController?

    deinit {
        guard let hasChildController = self.controller else {
            return
        }
        hasChildController.removeFromParentViewController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addTrainViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func addTrainViewController() {
        guard let hasViewModel = self.buyTrainViewModel else {
            assertionFailure("No view model defined")
            return
        }
        guard let gameObj = hasViewModel.game else {
            assertionFailure("No game object defined")
            return
        }

        let sb: UIStoryboard = UIStoryboard(name: "Train", bundle: nil)
        if let controller = sb.instantiateViewController(withIdentifier: "TrainViewController") as? TrainViewController
        {
            self.controller = controller
            self.controller?.trainsViewModel = TrainListViewModel.init(game: gameObj)

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

            controller.completionClosure = { (doneBtnPressed: Bool) in
                // end turn, handle whether to move to next page
                print ("doneBtn pressed")
            }
            controller.selectedTrainClosure = { (train: Locomotive?) in
                print ("selectedTrainClosure pressed")
                if let selectedTrain = train {
                    print ("You clicked on: \(selectedTrain.name)")
                    hasViewModel.selectedTrain = selectedTrain
                    self.performSegue(withIdentifier: "trainDetailSegue", sender: self)
                }
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        guard let hasViewModel = self.buyTrainViewModel else {
            assertionFailure("No view model defined")
            return
        }
        guard let hasGame = hasViewModel.game else {
            assertionFailure("No game object defined")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("No gameboard defined")
            return
        }


        if (segue.identifier == "trainDetailSegue") {
            guard let selectedTrain = self.buyTrainViewModel?.selectedTrain else {
                return
            }
            let vc : BuyTrainDetailViewController = (segue.destination as? BuyTrainDetailViewController)!
            vc.trainDetailViewModel = TrainDetailViewModel.init(game: hasGame, locomotive: selectedTrain)
            vc.completionClosure = { (didPurchase) in
                print ("didPurchase == \(didPurchase)")

                if (didPurchase) {
                    hasViewModel.handlePurchase()
                }
            }
        }

        if (segue.identifier == "productionSegue") {
            let vc : BuyProductionViewController = (segue.destination as? BuyProductionViewController)!
            vc.productionPageViewModel = ProductionPageViewModel.init(game: hasGame)
        }
    }


}

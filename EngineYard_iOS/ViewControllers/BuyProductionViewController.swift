//
//  BuyProductionViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class BuyProductionViewController: UIViewController {

    weak var controller: TrainViewController?
    var productionPageViewModel: ProductionPageViewModel!

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
        // Dispose of any resources that can be recreated.
    }

    private func addTrainViewController() {
        guard let hasViewModel = self.productionPageViewModel else {
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
            controller.selectedTrainClosure = { (purchasedTrain: Locomotive?) in
                print ("selectedTrainClosure pressed")
            }
        }
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

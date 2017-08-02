//
//  BuyTrainListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class BuyTrainListViewController: UIViewController {

    var viewModel: BuyTrainListViewModel?
    weak var trainListViewController: TrainListViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        addTrainViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        guard let hasChildController = self.trainListViewController else {
            return
        }
        hasChildController.removeFromParentViewController()
    }


    private func addTrainViewController() {
        guard let hasViewModel = self.viewModel else {
            assertionFailure("No view model defined")
            return
        }
        guard let gameObj = hasViewModel.game else {
            assertionFailure("No game object defined")
            return
        }
        guard let trains = hasViewModel.trains else {
            assertionFailure("There are no trains")
            return
        }

        // Launch Train View Controller
        let sb: UIStoryboard = UIStoryboard(name: "Trains", bundle: nil)
        if let controller = sb.instantiateViewController(withIdentifier: "TrainListViewController") as? TrainListViewController
        {
            self.trainListViewController = controller
            self.trainListViewController?.trainsListViewModel = TrainsListViewModel.init(game: gameObj, trains: trains)

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

            controller.doneBtnClosure = { (doneBtnPressed: Bool) in
                // end turn, handle whether to move to next page
                print ("doneBtn pressed")
            }
            controller.selectedTrainClosure = { (train: Train?) in
                print ("selectedTrainClosure pressed")
                if let selectedTrain = train {
                    print ("You clicked on: \(selectedTrain.name)")
                    //hasViewModel.selectedTrain = selectedTrain
                    //self.performSegue(withIdentifier: "trainDetailSegue", sender: self)
                }
            }
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if (segue.identifier == "buyTrainDetailSegue") {

        }
        if (segue.identifier == "productionSegue") {

        }

    }


}

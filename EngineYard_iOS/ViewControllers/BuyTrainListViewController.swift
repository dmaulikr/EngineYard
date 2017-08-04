//
//  BuyTrainListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

protocol BuyTrainAlertProtocol {
    func showAlert(message: Message)
}

class BuyTrainListViewController: UIViewController, BuyTrainAlertProtocol {

    var viewModel: BuyTrainListViewModel?
    weak var childVC: GenericTrainListViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel?.delegate = self

        addTrainViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        guard let hasChildController = self.childVC else {
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
        if let controller = sb.instantiateViewController(withIdentifier: "GenericTrainListViewController") as? GenericTrainListViewController
        {

            self.childVC = controller
            self.childVC?.genericTrainListViewModel = GenericTrainListViewModel.init(game: gameObj, trains: trains)
            self.childVC?.genericTrainListViewModel?.pageTitle = hasViewModel.pageTitle

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

                let identifier = "productionSegue"
                if (self.shouldPerformSegue(withIdentifier: identifier, sender: self)) {
                    self.performSegue(withIdentifier: identifier, sender: self)
                }
            }

            controller.selectedTrainClosure = { (train: Train?) in
                print ("selectedTrainClosure pressed")
                if let selectedTrain = train {
                    print ("You clicked on: \(selectedTrain.name)")

                    hasViewModel.selectedTrain = selectedTrain

                    let identifier = "trainDetailSegue"
                    if (self.shouldPerformSegue(withIdentifier: identifier, sender: self)) {
                        self.performSegue(withIdentifier: identifier, sender: self)
                    }
                }
            }
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        guard let hasViewModel = self.viewModel else {
            return false
        }

        return hasViewModel.shouldPerformSegue(identifier: identifier)
    }

    // Buy Train Alert delegate

    internal func showAlert(message: Message) {

        guard let title = message.title else {
            return
        }
        guard let message = message.message else {
            return
        }

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okString = NSLocalizedString("OK", comment: "OK")

        let actionOK = UIAlertAction(title: okString, style: .default) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }

        alertController.addAction(actionOK)

        self.present(alertController, animated: true, completion: nil)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.


        guard let hasViewModel = self.viewModel else {
            return
        }
        guard let hasGame = hasViewModel.game else {
            assertionFailure("** No game object defined **")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("** No game board defined **")
            return
        }
        guard let selectedTrain = hasViewModel.selectedTrain else {
            return
        }


        if (segue.identifier == "trainDetailSegue") {

            let vc : BuyTrainDetailViewController = (segue.destination as? BuyTrainDetailViewController)!
            vc.viewModel = BuyTrainDetailViewModel.init(game: hasGame, train: selectedTrain)

        }
        if (segue.identifier == "productionSegue") {

            let vc : BuyProductionListViewController = (segue.destination as? BuyProductionListViewController)!
            vc.viewModel = BuyProductionListViewModel.init(game: hasGame)
        }
        
    }
    
    
}

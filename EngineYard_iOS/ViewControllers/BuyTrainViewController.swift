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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func addTrainViewController() {
        let sb: UIStoryboard = UIStoryboard(name: "Train", bundle: nil)
        if let controller = sb.instantiateViewController(withIdentifier: "TrainViewController") as? TrainViewController
        {
            self.controller = controller
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
                self.moveToProductionSegue()
            }
        }
    }

    private func shouldMoveToProductionSegue() -> Bool {
        return true
    }

    private func moveToProductionSegue() {
        if (shouldMoveToProductionSegue()) {
            self.performSegue(withIdentifier: "productionSegue", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

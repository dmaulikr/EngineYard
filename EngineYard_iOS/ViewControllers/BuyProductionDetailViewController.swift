//
//  BuyProductionDetailViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class BuyProductionDetailViewController: UIViewController {

    weak var viewModel: BuyProductionDetailViewModel?

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var componentView: UIView!

    weak var cartVC: ProductionCartViewController!
    weak var rivalsVC: ProductionRivalsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cartVC = ProductionCartViewController()
        self.rivalsVC = ProductionRivalsViewController()
        
        addChildViewController(self.cartVC)
        addChildViewController(self.rivalsVC)

        NSLayoutConstraint.activate([
            self.cartVC.view.leadingAnchor.constraint(equalTo: self.componentView.leadingAnchor),
            self.cartVC.view.trailingAnchor.constraint(equalTo: self.componentView.trailingAnchor),
            self.cartVC.view.topAnchor.constraint(equalTo: self.componentView.topAnchor),
            self.cartVC.view.bottomAnchor.constraint(equalTo: self.componentView.bottomAnchor)
            ])

        self.didMove(toParentViewController: self)

        self.componentView.addSubview(self.cartVC.view)
        self.componentView.addSubview(self.rivalsVC.view)
        self.componentView.sendSubview(toBack: self.rivalsVC.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - IBActions

    @IBAction func segmentControlValueChanged(_ sender: Any) {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.componentView.bringSubview(toFront: self.cartVC.view)
            break

        case 1:
            self.componentView.bringSubview(toFront: self.rivalsVC.view)
            break

        default:
            break
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

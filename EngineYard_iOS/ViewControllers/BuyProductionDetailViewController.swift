//
//  BuyProductionDetailViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

struct ProductionCart {
    var train: Train?
    var units: Int
    var totalCost: Int = 0

    init(train: Train, units: Int = 0) {
        self.train = train
        self.units = units
    }

    func updateUnits() {

    }
}

class BuyProductionDetailViewController: UIViewController {

    weak var viewModel: BuyProductionDetailViewModel?

    var cartVC : ProductionCartViewController!
    var rivalsVC: ProductionRivalsViewController!

    @IBOutlet weak var childContentView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cartVC = ProductionCartViewController()
        self.rivalsVC = ProductionRivalsViewController()

        self.cartVC.doneBtnClosure = { (cart: Bool) in
            print ("cart -- ()")
        }

        self.addChildViewController(cartVC)
        self.addChildViewController(rivalsVC)

        self.childContentView.addSubview(cartVC.view)
        self.childContentView.addSubview(rivalsVC.view)
        self.childContentView.sendSubview(toBack: rivalsVC.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - IBActions

    @IBAction func segmentControlValueChanged(_ sender: Any) {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.childContentView.bringSubview(toFront: self.cartVC.view)
            break

        case 1:
            self.childContentView.bringSubview(toFront: self.rivalsVC.view)
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

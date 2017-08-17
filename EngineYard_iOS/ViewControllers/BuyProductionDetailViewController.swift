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


    override func viewDidLoad() {
        super.viewDidLoad()

        /*
        self.componentView.addSubview(self.productionCartView)
        self.componentView.addSubview(self.rivalsTableView)
        self.componentView.sendSubview(toBack: self.rivalsTableView)
         */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - IBActions

    @IBAction func segmentControlValueChanged(_ sender: Any) {

        switch segmentedControl.selectedSegmentIndex {
        case 0:
            //self.componentView.bringSubview(toFront: self.productionCartView)
            break

        case 1:
            //self.componentView.bringSubview(toFront: self.rivalsTableView)
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

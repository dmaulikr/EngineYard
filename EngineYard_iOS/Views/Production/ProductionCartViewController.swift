//
//  ProductionCartViewController.swift
//  EngineYard
//
//  Created by Amarjit on 17/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class ProductionCartViewController: UIViewController {

    @IBOutlet weak var myUnitsLbl: UILabel!

    @IBOutlet weak var cartUnitsLbl: UILabel!
    @IBOutlet weak var cartStepper: UIStepper!
    @IBOutlet weak var cartPricePerUnitLbl: UILabel!

    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var shiftProductionBtn: UIButton!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBActions

    @IBAction func stepperValueChanged(_ sender: Any) {
    }

    @IBAction func buyBtnPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
    }

    @IBAction func shiftProductionBtnPressed(_ sender: Any) {
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

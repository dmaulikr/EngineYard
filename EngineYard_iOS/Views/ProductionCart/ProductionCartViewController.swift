//
//  ProductionCartViewController.swift
//  EngineYard
//
//  Created by Amarjit on 17/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class ProductionCartViewController: UIViewController {

    var doneBtnClosure : ((_ cart: Bool)->())?

    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var shiftProductionBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions

    @IBAction func buyBtnPressed(_ sender: Any) {
        if let closure = self.doneBtnClosure {
            closure(true)
        }
    }

    @IBAction func shiftProductionBtnPressed(_ sender: Any) {
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return false
    }

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

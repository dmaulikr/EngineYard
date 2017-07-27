//
//  BuyTrainDetailViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class BuyTrainDetailViewController: UIViewController {

    var completionClosure : ((_ didPurchase: Bool)->())?
    var trainDetailViewModel: TrainDetailViewModel?
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var engineCardXIBView: EngineCardXibView!
    @IBOutlet weak var playerXIBView: PlayerXIBView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let buyBtnText = self.trainDetailViewModel?.buyButtonText else {
            return
        }
        self.buyBtn.setTitle(buyBtnText, for: .normal)
        self.buyBtn.layoutIfNeeded()
        self.buyBtn.sizeToFit()

        if let loco = self.trainDetailViewModel?.locomotive {
            let engineCard = self.engineCardXIBView.contentView as! EngineCardView
            engineCard.setup(loco: loco)
            EngineCardView.applyDropShadow(loco: loco, toView: self.engineCardXIBView)
            self.engineCardXIBView.layoutIfNeeded()

            //let hudCard = self.playerXIBView.contentView as! PlayerHUDView
            //hudCard.updatePlayerHUD(player: playerOnTurn)

        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions

    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if let closure = self.completionClosure {
                closure(false)
            }
        }
    }

    @IBAction func buyBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if let closure = self.completionClosure {
                closure(true)
            }
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

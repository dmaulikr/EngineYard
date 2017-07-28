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

        guard let viewModel = self.trainDetailViewModel else {
            assertionFailure("No view model found")
            return
        }
        guard let gameObj = viewModel.game else {
            assertionFailure("No game model found")
            return
        }
        guard let loco = viewModel.locomotive else {
            assertionFailure("No locomotive found")
            return
        }

        let titleText = viewModel.buyButtonText
        self.buyBtn.setTitle(titleText, for: .normal)
        self.buyBtn.layoutIfNeeded()
        self.buyBtn.sizeToFit()


        let engineCard = self.engineCardXIBView.contentView as! EngineCardView
        engineCard.setup(loco: loco)
        EngineCardView.applyDropShadow(loco: loco, toView: self.engineCardXIBView)
        self.engineCardXIBView.layoutIfNeeded()

        let playerOnTurn = gameObj.turnOrderManager.current

        let hudCard: PlayerHUDView = self.playerXIBView.contentView as! PlayerHUDView
        hudCard.setupUI(player: playerOnTurn)

        if (playerOnTurn.account.canAfford(amount: loco.cost) == false) {
            self.toggleBuyBtnState(enabled: false)
            print ("You cannot afford this locomotive! Cash: \(playerOnTurn.cash) vs Loco: \(loco.cost)")
        }
        else {
            self.toggleBuyBtnState(enabled: true)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func toggleBuyBtnState(enabled: Bool = true) {
        self.buyBtn.isEnabled = enabled
        if (!self.buyBtn.isEnabled) {
            self.buyBtn.layer.opacity = 0.5
        }
    }

    func showPurchaseAlert(completionClosure : @escaping ((_ willPurchase:Bool)->())) {
        guard let train = self.trainDetailViewModel?.locomotive else {
            completionClosure(false)
            return
        }

        let costNumber = NSNumber(integerLiteral: train.cost)
        let costString = ObjectCache.currencyRateFormatter.string(from: costNumber)!

        let alertController = UIAlertController(title: "Purchase train?",
                                                message: "Buy \(train.name) for \(costString)?",
                                                preferredStyle: .alert)

        let okString = NSLocalizedString("OK", comment: "OK")
        let cancelString = NSLocalizedString("Cancel", comment: "Cancel")

        let actionOK = UIAlertAction(title: okString, style: .default) { (action) in
            completionClosure(true)
        }
        let actionCancel = UIAlertAction(title: cancelString, style: .cancel) { (action) in
            completionClosure(false)
        }

        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)

        self.present(alertController, animated: true, completion: nil)
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
        guard let viewModel = self.trainDetailViewModel else {
            return
        }
        guard let gameObj = viewModel.game else {
            return
        }
        guard let loco = viewModel.locomotive else {
            return
        }

        let playerOnTurn = gameObj.turnOrderManager.current
        if (playerOnTurn.account.canAfford(amount: loco.cost))
        {

            showPurchaseAlert { (willPurchase) in
                if (willPurchase) {

                    viewModel.purchaseTrain(train: loco, player: playerOnTurn)

                    waitFor(duration: 1.0) { (complete: Bool) in
                        if (complete) {
                            self.dismiss(animated: true) {
                                if let closure = self.completionClosure {
                                    closure(true)
                                }
                            }
                        }
                    }

                }
            }

        }
        else {
            print ("Can't afford \(loco.description)")
            return
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

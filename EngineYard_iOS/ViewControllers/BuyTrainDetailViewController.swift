//
//  BuyTrainDetailViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import GSMessages

class BuyTrainDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var viewModel: BuyTrainDetailViewModel?
    var completionClosure : ((_ didPurchase: Bool)->())?

    @IBOutlet weak var engineCardXIBView: EngineCardXibView!
    @IBOutlet weak var playerXIBView: PlayerXIBView!

    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var rivalTitleLabel: UILabel!
    @IBOutlet weak var rivalOwnersTableView: UITableView!
    @IBOutlet weak var buyBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var noRivalOwnersLabel: UILabel!
    @IBOutlet weak var buyTrainLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.rivalOwnersTableView.register(UINib(nibName: "RivalTrainOwnersTableViewCell", bundle: nil), forCellReuseIdentifier: "RivalTrainOwnersTableViewCell")
        self.rivalOwnersTableView.delegate = self
        self.rivalOwnersTableView.dataSource = self
        self.rivalOwnersTableView.allowsSelection = false
        self.rivalOwnersTableView.allowsMultipleSelection = false

        self.noRivalOwnersLabel.isHidden = true

        if let hasViewModel = self.viewModel {
            setupTrainView(viewModel: hasViewModel)
            setupPlayerView(viewModel: hasViewModel)

            print ("rivals -- \(hasViewModel.rivals)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Setup UI

    func setupPlayerView(viewModel: BuyTrainDetailViewModel) {
        guard let gameObj = viewModel.game else {
            return
        }
        let playerOnTurn: Player = gameObj.turnOrderManager.current

        let hudCardView: PlayerHUDView = self.playerXIBView.contentView as! PlayerHUDView
        hudCardView.setupUI(player: playerOnTurn)
        hudCardView.layoutIfNeeded()

        // can afford train?
        if let train = viewModel.train {
            if (!playerOnTurn.wallet.canAfford(amount: train.cost)) {
                self.showMessage("You cannot afford this train", type: .error)
                self.toggleBuyButton(false)
            }
            else {
                self.showMessage("Buying this train will add to your portfolio and unlock the next train", type: .info)
                self.toggleBuyButton(true)
            }
        }
    }

    func toggleBuyButton(_ state: Bool = true) {
        if (state) {
            self.buyBtn.isEnabled = true
            self.buyBtn.alpha = 1.0
            self.buyTrainLabel.isHidden = false
        }
        else {
            self.buyBtn.isEnabled = false
            self.buyBtn.alpha = 0.5
            self.buyTrainLabel.isHidden = true

        }
    }

    func setupTrainView(viewModel: BuyTrainDetailViewModel) {
        guard let _ = viewModel.game else {
            return
        }
        guard let train = viewModel.train else {
            return
        }
        guard let trainBuyText = viewModel.buyTrainText else {
            return
        }

        let engineCard = self.engineCardXIBView.contentView as! EngineCardView
        engineCard.setup(with: train)
        EngineCardView.applyDropShadow(train: train, forView: self.engineCardXIBView!)

        // setup buy button text
        self.buyTrainLabel.text = trainBuyText

        guard let rivals = viewModel.rivals else {
            return
        }
        if (rivals.count == 0) {
            self.noRivalOwnersLabel.isHidden = false
            self.rivalOwnersTableView.isHidden = true
        }
    }

    // MARK: - UITableView delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hasViewModel = self.viewModel else {
            return 0
        }
        guard let hasRivals = hasViewModel.rivals else {
            return 0
        }
        return hasRivals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RivalTrainOwnersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RivalTrainOwnersTableViewCell", for: indexPath) as! RivalTrainOwnersTableViewCell

        guard let hasViewModel = self.viewModel else {
            return cell
        }

        hasViewModel.configureWithCell(cell: cell, atIndexPath: indexPath)        

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }

    // MARK: - IBActions

    @IBAction func buyBtnPressed(_ sender: UIButton) {
        print("buy btn pressed")

        guard let hasViewModel = self.viewModel else {
            return
        }
        guard let playerOnTurn = hasViewModel.playerOnTurn else {
            return
        }

        if let train = hasViewModel.train {

            // #TODO refactor checking
            if ((playerOnTurn.wallet.canAfford(amount: train.cost)) && (playerOnTurn.hand.containsTrain(train: train) == false))
            {
                showPurchaseAlert(completionClosure: { (willPurchase) in
                    if (willPurchase) {
                        hasViewModel.purchase()
                        
                        self.waitAndClose()
                    }
                })
            }
        }
    }

    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        print("cancel btn pressed")

        self.dismiss(animated: true) {
            if let closure = self.completionClosure {
                closure(false)
            }
        }
    }

    func waitAndClose() {
        waitFor(duration: 1.0) { (complete: Bool) in
            if (complete) {
                self.dismiss(animated: true, completion: {
                    if let closure = self.completionClosure {
                        closure(true)
                    }
                })
            }
        }
    }

    // MARK: - Purchase Alert

    func showPurchaseAlert(completionClosure : @escaping ((_ willPurchase:Bool)->())) {

        guard let viewModel = self.viewModel else {
            return
        }
        guard let messageObj = viewModel.purchaseTrainAlertMessage else {
            return
        }
        guard let messageTitle = messageObj.title else {
            return
        }
        guard let messageBody = messageObj.message else {
            return
        }

        // Show alert
        let alertController = UIAlertController(title: messageTitle,
                                                message: messageBody,
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

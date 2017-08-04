//
//  BuyTrainDetailViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class BuyTrainDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var viewModel: BuyTrainDetailViewModel?

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
    }

    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        print("cancel btn pressed")
        self.dismiss(animated: true, completion: nil)
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

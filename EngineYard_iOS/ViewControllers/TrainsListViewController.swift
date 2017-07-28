//
//  TrainsListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import GSMessages

class TrainsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var trainsViewModel: BuyTrainViewModel?
    var doneBtnClosure : ((_ doneBtnPressed: Bool)->())?
    var selectedTrainClosure : ((_ train: Locomotive?)->())?

    weak var HUD: HUDViewController?
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var trainsCollectionView: UICollectionView!
    @IBOutlet weak var doneBtn: UIButton!

    deinit {
        self.HUD = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.HUD = HUDViewController.loadHUD(game: self.trainsViewModel?.game, viewController: self)

        self.trainsCollectionView.delegate = self
        self.trainsCollectionView.dataSource = self
        self.trainsCollectionView.register(EngineCardCollectionViewCell.self, forCellWithReuseIdentifier: EngineCardCollectionViewCell.cellReuseIdentifier)
        self.trainsCollectionView.backgroundColor = UIColor.clear
        self.trainsCollectionView.delegate = self
        self.trainsCollectionView.dataSource = self
        self.trainsCollectionView.allowsMultipleSelection = false
        self.trainsCollectionView.layoutIfNeeded()

        self.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func reload() {
        self.trainsCollectionView.reloadData()

        guard let hasHUD = self.HUD else {
            return
        }
        hasHUD.reloadHUD()

        guard let hasViewModel = self.trainsViewModel else {
            return
        }

        if (hasViewModel.didPurchaseTrain) {
            self.trainsCollectionView.isUserInteractionEnabled = false
            self.trainsCollectionView.layer.opacity = 0.5

            showMessage("Please press END TURN", type: .info)
        }
        else {
            self.showMessage("Pick a train to buy, or press END TURN", type: .info)
        }
    }

    // MARK: - CollectionView delegate

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let trains = self.trainsViewModel?.trains else {
            return 0
        }
        return trains.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EngineCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: EngineCardCollectionViewCell.cellReuseIdentifier, for: indexPath) as! EngineCardCollectionViewCell

        self.configureCell(cell: cell, atIndexPath: indexPath)

        cell.layoutIfNeeded()

        return cell
    }

    func configureCell(cell: EngineCardCollectionViewCell, atIndexPath: IndexPath)
    {
        if let viewModel = self.trainsViewModel
        {
            if cell.engineCardView == nil {
                let arr = UINib(nibName: "EngineCardView", bundle: nil).instantiate(withOwner: nil, options: nil)
                let view = arr[0] as! EngineCardView
                cell.contentView.addSubview(view)
                cell.engineCardView = view
            }

            if let trains = viewModel.trains {
                let loco: Locomotive = trains[atIndexPath.row]
                print(atIndexPath.row, loco.description)
                cell.engineCardView?.setup(loco:loco)
                EngineCardView.applyDropShadow(loco: loco, toView: cell)

                if ((loco.isUnlocked == false) || (viewModel.didPurchaseTrain == true))
                {
                    cell.isUserInteractionEnabled = false
                    cell.layer.opacity = 0.35
                }
                else {
                    cell.isUserInteractionEnabled = true
                    cell.layer.opacity = 1.0
                }
                guard let owners = loco.owners else {
                    return
                }
                guard let currentPlayer = self.trainsViewModel?.playerOnTurn else {
                    return
                }
                if (owners.contains(currentPlayer)) {
                    cell.engineCardView?.checkMark.isHidden = false
                }
                else {
                    cell.engineCardView?.checkMark.isHidden = true
                }
            }
        }
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")

        guard let trains = self.trainsViewModel?.trains else {
            return
        }

        self.trainsViewModel?.selectedTrain = trains[indexPath.row]
        self.performSegue(withIdentifier: "trainDetailSegue", sender: self)
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        print ("Pressed done")

        guard let hasModel = self.trainsViewModel else {
            return
        }

        if (hasModel.didPurchaseTrain == false)
        {
            let title = BuyTrainViewModel.NoTrainBoughtMessage.title
            let message = BuyTrainViewModel.NoTrainBoughtMessage.message

            showAlert(title: title, message: message, completion: { (okPressed) in
                if (okPressed) {
                    // advance next turn, but for now, advance to next screen
                    self.performSegue(withIdentifier: "productionSegue", sender: self)
                }
            })
        }
        else {
            self.performSegue(withIdentifier: "productionSegue", sender: self)
        }
    }

    func showAlert(title: String, message: String, completion:@escaping ((_ okPressed:Bool )->()))
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let ok = NSLocalizedString("OK", comment: "OK")
        let cancel = NSLocalizedString("Cancel", comment: "Cancel")

        let okAction = UIAlertAction(title: ok, style: .default) { (action) in
            completion(true)
        }
        let cancelAction = UIAlertAction(title: cancel, style: .cancel) { (action) in
            completion(false)
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        guard let hasGame = self.trainsViewModel?.game else {
            assertionFailure("No game object defined")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("No gameboard defined")
            return
        }

        if (segue.identifier == "productionSegue") {
            let vc : BuyProductionViewController = (segue.destination as? BuyProductionViewController)!
            vc.productionPageViewModel = ProductionPageViewModel.init(game: hasGame)
        }

        if (segue.identifier == "trainDetailSegue") {
            guard let selectedTrain = self.trainsViewModel?.selectedTrain else {
                return
            }
            let vc : BuyTrainDetailViewController = (segue.destination as? BuyTrainDetailViewController)!
            vc.trainDetailViewModel = TrainDetailViewModel.init(game: hasGame, locomotive: selectedTrain)
            vc.completionClosure = { (didPurchase) in
                print ("didPurchase == \(didPurchase)")

                if (didPurchase) {
                    self.trainsViewModel?.didPurchaseTrain = didPurchase
                    self.reload()
                }
                else {
                    self.showMessage("Pick a train to buy, or press END TURN", type: .info)
                }
            }
        }
    }


}

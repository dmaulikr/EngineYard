//
//  TrainViewController.swift
//  EngineYard
//
//  Created by Amarjit on 29/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

// Generic train view controller used for various pages

class TrainViewController: UIViewController
    //, UICollectionViewDelegate, UICollectionViewDataSource
{
    var doneClosure : ((_ doneBtnPressed: Bool)->())?
    var selectedTrainClosure : ((_ train: Train?)->())?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        if let closure = self.doneClosure {
            closure(true)
        }
    }


    /***
    var trainsListViewModel: PurchaseableTrainsViewModel?
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

        self.HUD = HUDViewController.loadHUD(game: self.trainsListViewModel?.game, viewController: self)

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
        guard let hud = self.HUD else {
            return
        }
        hud.reloadHUD()
        self.trainsCollectionView.reloadData()
    }

    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.trainsListViewModel else {
            return 0
        }
        guard let trains = viewModel.trains else {
            return 0
        }
        return trains.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EngineCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: EngineCardCollectionViewCell.cellReuseIdentifier, for: indexPath) as! EngineCardCollectionViewCell

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        print ("Done pressed")
        if let closure = self.doneBtnClosure {
            closure(true)
        }
    }
    **/
}

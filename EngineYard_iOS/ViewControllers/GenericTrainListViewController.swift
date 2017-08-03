//
//  GenericTrainListViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

//
// Generic view controller listing trains in a given deck
//

class GenericTrainListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    public var genericTrainListViewModel: GenericTrainListViewModel?

    var doneBtnClosure : ((_ doneBtnPressed: Bool)->())?
    var selectedTrainClosure : ((_ train: Train?)->())?

    weak var HUD: HUDViewController?
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var trainsCollectionView: UICollectionView!
    @IBOutlet weak var doneBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.HUD = HUDViewController.loadHUD(game: self.genericTrainListViewModel?.game, viewController: self)

        self.trainsCollectionView.delegate = self
        self.trainsCollectionView.dataSource = self
        self.trainsCollectionView.register(EngineCardCollectionViewCell.self, forCellWithReuseIdentifier: EngineCardCollectionViewCell.cellReuseIdentifier)
        self.trainsCollectionView.backgroundColor = UIColor.clear
        self.trainsCollectionView.delegate = self
        self.trainsCollectionView.dataSource = self
        self.trainsCollectionView.allowsMultipleSelection = false

        self.trainsCollectionView.layoutIfNeeded()

        if let pageTitle = self.genericTrainListViewModel?.pageTitle {
            self.pageTitleLabel.text = pageTitle
        }

        self.view.layoutIfNeeded()

        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        self.HUD = nil
    }

    func reloadData() {
        guard let hud = self.HUD else {
            return
        }
        hud.reloadHUD()
        self.trainsCollectionView.reloadData()
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        print ("Done pressed")
        if let closure = self.doneBtnClosure {
            closure(true)
        }
    }

    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let trains = self.genericTrainListViewModel?.trains else {
            return 0
        }
        return trains.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: EngineCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: EngineCardCollectionViewCell.cellReuseIdentifier, for: indexPath) as! EngineCardCollectionViewCell

        if cell.engineCardView == nil {
            let arr = UINib(nibName: "EngineCardView", bundle: nil).instantiate(withOwner: nil, options: nil)
            let view = arr[0] as! EngineCardView
            cell.contentView.addSubview(view)
            cell.engineCardView = view
        }

        if let trains = self.genericTrainListViewModel?.trains {
            let train: Train = trains[indexPath.row]

            print(indexPath.row, train.description)

            cell.engineCardView?.setup(with: train)

            EngineCardView.applyDropShadow(train: train, forView: cell)
            
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let hasViewModel = self.genericTrainListViewModel else {
            return true
        }
        return hasViewModel.shouldSelectItemAt
    }

}

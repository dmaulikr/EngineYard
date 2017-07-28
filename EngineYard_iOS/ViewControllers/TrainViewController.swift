//
//  TrainViewController.swift
//  EngineYard
//
//  Created by Amarjit on 26/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

struct TrainListViewModel
{
    weak var game: Game?
    var trains: [Locomotive]?

    init(game: Game, trains:[Locomotive]?) {
        self.game = game
        if let hasTrains = trains {
            self.trains = hasTrains
        }
    }
}

class TrainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{

    weak var HUD: HUDViewController?
    var trainsViewModel: TrainListViewModel!

    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var trainsCollectionView: UICollectionView!
    @IBOutlet weak var doneBtn: UIButton!

    var completionClosure : ((_ doneBtnPressed: Bool)->())?
    var selectedTrainClosure : ((_ train: Locomotive?)->())?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let hasGame = self.trainsViewModel.game else {
            assertionFailure("** No game object defined **")
            return
        }

        self.HUD = HUDViewController.loadHUD(game: hasGame, viewController: self)

        self.trainsCollectionView.delegate = self
        self.trainsCollectionView.dataSource = self
        self.trainsCollectionView.register(EngineCardCollectionViewCell.self, forCellWithReuseIdentifier: EngineCardCollectionViewCell.cellReuseIdentifier)
        self.trainsCollectionView.backgroundColor = UIColor.clear
        self.trainsCollectionView.delegate = self
        self.trainsCollectionView.dataSource = self
        self.trainsCollectionView.allowsMultipleSelection = false
        self.trainsCollectionView.layoutIfNeeded()
        self.trainsCollectionView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let trains = self.trainsViewModel.trains else {
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

        if let trains = self.trainsViewModel.trains {
            let loco: Locomotive = trains[indexPath.row]
            print(indexPath.row, loco.description)
            cell.engineCardView?.setup(loco:loco)
            EngineCardView.applyDropShadow(loco: loco, toView: cell)
        }

        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")

        guard let trains = self.trainsViewModel.trains else {
            return
        }

        let train: Locomotive = trains[indexPath.row]

        if let closure = self.selectedTrainClosure {
            closure(train)
        }
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        print ("Done pressed")
        if let closure = self.completionClosure {
            closure(true)
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

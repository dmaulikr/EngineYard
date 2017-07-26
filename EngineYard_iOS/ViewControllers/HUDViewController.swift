//
//  EYHUDViewController.swift
//  EngineYard
//
//  Created by Amarjit on 30/03/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import SVProgressHUD
import QuartzCore

class HUDViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var game: Game?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.register(HUDCollectionViewCell.self, forCellWithReuseIdentifier: HUDCollectionViewCell.cellReuseIdentifer)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Load HUD
    
    public static func loadHUD(game:Game?, viewController:UIViewController) -> HUDViewController? {
        let sb: UIStoryboard = UIStoryboard(name: "HUD", bundle: nil)
        let hudVC = sb.instantiateViewController(withIdentifier: "HUDViewController") as? HUDViewController

        if let controller = hudVC
        {
            let view = viewController.view!
            if let gameObj = game {
                controller.game = gameObj
            }

            viewController.addChildViewController(controller)
            controller.view.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(controller.view)

            NSLayoutConstraint.activate([
                controller.view.topAnchor.constraint(equalTo: view.topAnchor),
                controller.view.leftAnchor.constraint(equalTo: view.leftAnchor),
                controller.view.rightAnchor.constraint(equalTo: view.rightAnchor),
                ])

            controller.didMove(toParentViewController: viewController)
        }

        return hudVC
    }

    // MARK: - IBActions

    @IBAction func menuButtonPressed(_ sender:UIButton) {
        print ("Pressed")
    }

    // MARK: - Functions

    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let gameObj = self.game {
            return gameObj.players.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HUDCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HUDCollectionViewCell.cellReuseIdentifer, for: indexPath) as! HUDCollectionViewCell

        let arr = UINib(nibName: "PlayerHUDView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerHUDView
        cell.contentView.addSubview(view)

        if let gameObj = self.game {
            let allPlayers = gameObj.players
            let player: Player = allPlayers[indexPath.row]
            view.updatePlayerHUD(player: player)

            if (gameObj.turnOrderManager.turnOrderIndex == indexPath.row)
            {
                let border = CALayer()
                border.backgroundColor = UIColor(colorLiteralRed: 23/255, green: 234/255, blue: 217/255, alpha: 0.75).cgColor
                let width = CGFloat(2.0)
                border.frame = CGRect(x: 0, y: cell.frame.size.height + 5 - width, width: cell.frame.size.width - 10, height: width)
                cell.layer.addSublayer(border)
            }
        }

        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath)
    }
    

}

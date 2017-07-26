//
//  HUDViewController.swift
//  EngineYard
//
//  Created by Amarjit on 26/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit
import SVProgressHUD
import QuartzCore

class HUDViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuBtn: UIButton!

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

    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    public static func loadHUD(game: Game?, viewController: UIViewController) -> HUDViewController? {
        let sb: UIStoryboard = UIStoryboard(name: "HUD", bundle: nil)
        let hudVC = sb.instantiateViewController(withIdentifier: "HUDViewController") as? HUDViewController

        if let controller = hudVC
        {
            let view = viewController.view!
            //controller.gameModel = gameModel
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


    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HUDCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HUDCollectionViewCell.cellReuseIdentifer, for: indexPath) as! HUDCollectionViewCell

        let arr = UINib(nibName: "PlayerHUDView", bundle: nil).instantiate(withOwner: nil, options: nil)
        let view = arr[0] as! PlayerHUDView
        cell.contentView.addSubview(view)

        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath)
    }

    // MARK: - IBActions

    @IBAction func menuBtnPressed(_ sender:UIButton) {
        print ("Pressed")
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

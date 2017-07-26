//
//  NewTurnOrderViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class NewTurnOrderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{

    @IBOutlet weak var turnOrderCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.turnOrderCollectionView.delegate = self
        self.turnOrderCollectionView.dataSource = self
        self.turnOrderCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "NewTurnOrderCollectionViewCellReuseID")
        self.turnOrderCollectionView.backgroundColor = UIColor.clear
        self.turnOrderCollectionView.delegate = self
        self.turnOrderCollectionView.dataSource = self
        self.turnOrderCollectionView.allowsMultipleSelection = false
        self.turnOrderCollectionView.allowsSelection = false
        self.turnOrderCollectionView.layoutIfNeeded()
        self.turnOrderCollectionView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTurnOrderCollectionViewCellReuseID", for: indexPath) as UICollectionViewCell

        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
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

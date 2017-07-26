//
//  TaxesViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class TaxesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate
{
    @IBOutlet weak var taxCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.taxCollectionView.delegate = self
        self.taxCollectionView.dataSource = self
        self.taxCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "TaxCollectionViewCellReuseID")
        self.taxCollectionView.backgroundColor = UIColor.clear
        self.taxCollectionView.delegate = self
        self.taxCollectionView.dataSource = self
        self.taxCollectionView.allowsMultipleSelection = false
        self.taxCollectionView.allowsSelection = false
        self.taxCollectionView.layoutIfNeeded()
        self.taxCollectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaxCollectionViewCellReuseID", for: indexPath) as UICollectionViewCell

        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print ("Selected indexPath: \(indexPath)")
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

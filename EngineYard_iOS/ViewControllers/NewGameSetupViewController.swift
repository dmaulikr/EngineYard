//
//  NewGameSetupViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

protocol StepperProtocol {
    func stepperValueDidChange()
}


class NewGameViewModel
{
    
}

class NewGameSetupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, StepperProtocol
{
    var viewModel: NewGameViewModel?

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doneBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.stepper.minimumValue = Double(Constants.NumberOfPlayers.min)
        self.stepper.maximumValue = Double(Constants.NumberOfPlayers.max)
        //self.stepper.value = Double(self.viewModel.players.count)

        self.collectionView.register(UINib(nibName:"AddPlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPlayerCellReuseID")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - StepperProtocol

    internal func stepperValueDidChange() {
        //self.stepperLabel.text = self.viewModel.stepperLabelText
        self.stepperLabel.sizeToFit()
    }

    // MARK: - IBActions

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
    }

    @IBAction func doneBtnPressed(_ sender: UIButton) {

    }

    // MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 //self.viewModel.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddPlayerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPlayerCellReuseID", for: indexPath) as! AddPlayerCollectionViewCell



        /*
        let playerObj = viewModel.players[indexPath.row]

        if let avatar = UIImage(named: playerObj.asset) {
            cell.avtBtn.setImage(avatar, for: .normal)
        }

        cell.aiSwitchBtn.isSelected = playerObj.isAI
         */
        cell.layoutIfNeeded()

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print (indexPath)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        /*
        guard let hasGame = self.viewModel?.game else {
            return
        }

        guard let _ = hasGame.gameBoard else {
            assertionFailure("No gameboard defined")
            return
        }
        
        if (segue.identifier == "") {
            
        }
         */
    }


}

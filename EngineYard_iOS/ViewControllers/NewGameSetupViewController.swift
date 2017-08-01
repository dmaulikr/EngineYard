//
//  NewGameSetupViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

protocol StepperProtocol {
    func updateStepperText()
}


class NewGameViewModel
{
    var delegate: StepperProtocol?

    var players: [Player]?
    var stepperValue: Int = Constants.NumberOfPlayers.max {
        didSet {
            delegate?.updateStepperText()
        }
    }

    private(set) var playersCopy:[Player] = [Player]()

    lazy var numberOfItemsInSection : Int = {
        guard let players = self.players else {
            return 0
        }
        return players.count
    }()

    lazy var stepperLabelText: String = {
        guard let hasPlayers = self.players else {
            return "- No players defined -"
        }
        return NSLocalizedString("\(hasPlayers.count) Players", comment: "Label for number of players in game")
    }()


    init(playerCount:Int = Constants.NumberOfPlayers.max) {
        self.stepperValue = playerCount

        for idx:Int in 1...playerCount {
            let name = "Player #\(idx)"
            let filename = "avt_\(idx)"

            var isAI: Bool = true
            if (idx == 1) {
                isAI = false
            }

            let playerObj = Player.init(name: name, isAI: isAI, asset: filename)
            self.players?.append(playerObj)
        }

        print ("#: \(self.players?.count) players")
    }

    func configureCell(cell: AddPlayerCollectionViewCell, atIndexPath: IndexPath) {

        guard let playerList = self.players else {
            return
        }

        let playerObj = playerList[atIndexPath.row]

        if let avatar = UIImage(named: playerObj.asset) {
            cell.avtBtn.setImage(avatar, for: .normal)
        }
        cell.aiSwitchBtn.isSelected = playerObj.isAI
    }

    func stepperValueDidChange(value: Int) {
        if value > self.stepperValue {
            self.addPlayer()
        }
        else {
            self.removePlayer()
        }
        self.stepperValue = value
    }

    func addPlayer() {

        guard let hasPlayers = self.players else {
            return
        }

        if (hasPlayers.count < Constants.NumberOfPlayers.max) {
            if let lastPlayerCopy = playersCopy.last {
                self.players?.append(lastPlayerCopy)
                self.playersCopy.removeLast()
            }
        }
    }

    func removePlayer() {
        guard var hasPlayers = self.players else {
            return
        }

        if (hasPlayers.count > Constants.NumberOfPlayers.min) {
            if let lastPlayer = hasPlayers.last {
                self.playersCopy.append(lastPlayer)
                hasPlayers.removeLast()
            }
        }
    }
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
        self.viewModel?.delegate = self

        self.collectionView.register(UINib(nibName:"AddPlayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPlayerCellReuseID")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions

    @IBAction func stepperValueChanged(_ sender: UIStepper) {

    }

    @IBAction func doneBtnPressed(_ sender: UIButton) {

    }

    internal func updateStepperText() {
        self.stepperLabel.text = self.viewModel?.stepperLabelText
        self.stepperLabel.layoutIfNeeded()
    }

    // MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let numberOfItems = self.viewModel?.numberOfItemsInSection else {
            return 0
        }
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddPlayerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPlayerCellReuseID", for: indexPath) as! AddPlayerCollectionViewCell

        self.viewModel?.configureCell(cell: cell, atIndexPath: indexPath)

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

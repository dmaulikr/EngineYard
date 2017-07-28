//
//  NewGameViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

protocol StepperProtocol {
    func updateStepperValue()
}

struct NewGameViewModel {
    var delegate: StepperProtocol?
    weak var game : Game?

    private(set) var players:[Player] = [Player]()
    private(set) var playersCopy:[Player] = [Player]()

    var oldStepperValue:Int! {
        didSet {
            delegate?.updateStepperValue()
        }
    }

    init(playerCount:Int = Constants.NumberOfPlayers.max) {
        self.oldStepperValue = playerCount

        for idx:Int in 1...playerCount {
            let name = "Player #\(idx)"
            let filename = "avt_\(idx)"

            var isAI: Bool = true
            if (idx == 1) {
                isAI = false
            }

            let playerObj = Player.init(name: name, isAI: isAI, asset: filename)
            self.players.append(playerObj)
        }
    }

    mutating func addPlayer()
    {
        if (self.players.count < Constants.NumberOfPlayers.max) {
            if let lastPlayerCopy = playersCopy.last {
                self.players.append(lastPlayerCopy)
                self.playersCopy.removeLast()
            }
        }
    }

    mutating func removePlayer()
    {
        if (self.players.count > Constants.NumberOfPlayers.min) {
            if let lastPlayer = self.players.last {
                self.playersCopy.append(lastPlayer)
                self.players.removeLast()
            }
        }
    }

    public var stepperLabelText: String {
        return NSLocalizedString("\(players.count) Players", comment: "Label for number of players in game")
    }

    public mutating func setStepperValue(value: Int) {

        if value > self.oldStepperValue {
            self.addPlayer()
        }
        else {
            self.removePlayer()
        }
        self.oldStepperValue = value

    }
}


class NewGameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, StepperProtocol
{
    var viewModel: NewGameViewModel!

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doneBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = NewGameViewModel.init(playerCount: Constants.NumberOfPlayers.max)
        self.viewModel.delegate = self

        self.stepper.minimumValue = Double(Constants.NumberOfPlayers.min)
        self.stepper.maximumValue = Double(Constants.NumberOfPlayers.max)
        self.stepper.value = Double(self.viewModel.players.count)

        self.stepperLabel.text = viewModel.stepperLabelText

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

    internal func updateStepperValue() {
        self.stepperLabel.text = self.viewModel.stepperLabelText
        self.stepperLabel.sizeToFit()
    }

    // MARK: - IBActions

    @IBAction func stepperValueDidChange(_ sender: UIStepper) {
        let stepperValue:Int = Int(stepper.value)

        self.viewModel.setStepperValue(value: stepperValue)
        self.collectionView.reloadData()
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func doneBtnPresed(_ sender: UIButton) {
        guard let gameObj = self.viewModel.game else {
            return
        }

        if (gameObj.inProgress)
        {
            self.abandonGameAlert(completionClosure: { (abandoned) in
                guard let didAbandon = abandoned else {
                    return
                }
                if (didAbandon) {
                    gameObj.abandon()
                    self.launchGame()
                }
            })
        }
        else {
            self.launchGame()
        }
    }

    func launchGame() {
        self.viewModel.game = Game.setup(players: self.viewModel.players)
        waitFor(duration: 0.75) { (completed) in
            if (completed) {
                self.performSegue(withIdentifier: "buyTrainSegue", sender: self)
            }
        }
    }

    func abandonGameAlert(completionClosure : @escaping ((_ abandoned:Bool?)->())) {
        let alertController = UIAlertController(title: "Abandon game?",
                                                message: "Do you wish to abandon the current game",
                                                preferredStyle: .alert)

        let okString = NSLocalizedString("OK", comment: "OK")
        let cancelString = NSLocalizedString("Cancel", comment: "Cancel")

        let actionOK = UIAlertAction(title: okString, style: .default) { (action) in
            completionClosure(true)
        }
        let actionCancel = UIAlertAction(title: cancelString, style: .destructive, handler: nil)

        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)

        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.players.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddPlayerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPlayerCellReuseID", for: indexPath) as! AddPlayerCollectionViewCell

        let playerObj = viewModel.players[indexPath.row]

        if let avatar = UIImage(named: playerObj.asset) {
            cell.avtBtn.setImage(avatar, for: .normal)
        }

        cell.aiSwitchBtn.isSelected = playerObj.isAI
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
        guard let hasGame = self.viewModel.game else {
            assertionFailure("No game object defined")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("No gameboard defined")
            return
        }

        if (segue.identifier == "buyTrainSegue") {
            let vc : BuyTrainViewController = (segue.destination as? BuyTrainViewController)!
            vc.buyTrainViewModel = BuyTrainViewModel.init(game: hasGame)
        }
    }
    

}

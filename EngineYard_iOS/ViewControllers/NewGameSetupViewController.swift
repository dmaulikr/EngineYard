//
//  NewGameSetupViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

protocol StepperProtocol {
    func updateStepperLabel(with text: String)
}

class NewGameViewModel
{
    var game: Game = Game.instance
    var delegate: StepperProtocol?

    private(set) var players: [Player] = [Player]()

    public var stepperValue: Int = Constants.NumberOfPlayers.max {
        didSet {
            let text = NSLocalizedString("\(self.stepperValue) Players", comment: "Label for number of players in game")
            delegate?.updateStepperLabel(with: text)
        }
    }

    init() {
        self.stepperValue = Constants.NumberOfPlayers.max

        for idx:Int in 1...self.stepperValue {
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

    func configureCell(cell: AddPlayerCollectionViewCell, atIndexPath: IndexPath) {
        let playerObj = self.players[atIndexPath.row]

        if let avatar = UIImage(named: playerObj.asset) {
            cell.avtBtn.setImage(avatar, for: .normal)
        }
        cell.aiSwitchBtn.isSelected = playerObj.isAI

    }

    func stepperValueDidChange(value: Int) {
        self.stepperValue = value
    }

    func launchGame() {
        guard let gameObj = Game.setup(players: self.players) else {
            assertionFailure("Invalid game object")
            return
        }
        guard let _ = gameObj.gameBoard else {
            assertionFailure("Invalid game board")
            return
        }
        self.game = gameObj
        print (self.game.description)
    }
}

class NewGameSetupViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, StepperProtocol
{

    var viewModel: NewGameViewModel?

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = NewGameViewModel.init()

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
        self.viewModel?.stepperValueDidChange(value: Int(sender.value))
        self.collectionView.reloadData()
    }

    @IBAction func doneBtnPressed(_ sender: UIButton) {

        print (self.viewModel?.game.description as Any)

        self.launchGame()
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }


    internal func updateStepperLabel(with text: String) {
        self.stepperLabel.text = text
        self.stepperLabel.layoutIfNeeded()
    }

    func launchGame() {
        guard let hasViewModel = self.viewModel else {
            return
        }
        hasViewModel.launchGame()

        waitFor(duration: 0.85) { (completed) in
            if (completed) {
                self.performSegue(withIdentifier: "buyTrainSegue", sender: self)
            }
        }
    }

    // MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let value = self.viewModel?.stepperValue else {
            return 0
        }
        return value
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

        guard let hasGame = self.viewModel?.game else {
            assertionFailure(ErrorCode.noGameObjectDefined.localizedDescription)
            return
        }

        guard let _ = hasGame.gameBoard else {
            assertionFailure(ErrorCode.noGameBoardDefined.localizedDescription)
            return
        }

        if (segue.identifier == "buyTrainSegue") {

            let vc : BuyTrainListViewController = (segue.destination as? BuyTrainListViewController)!
            vc.viewModel = BuyTrainListViewModel.init(game: hasGame)

        }

    }
}


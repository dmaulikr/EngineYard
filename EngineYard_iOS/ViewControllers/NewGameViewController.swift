//
//  NewGameViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

struct NewGameViewModel {
    private(set) var players:[Player] = [Player]()
    private(set) var playersCopy:[Player] = [Player]()

    var oldStepperValue:Int = Int()

    init(playerCount:Int = Constants.NumberOfPlayers.max) {
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
}


class NewGameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    var viewModel: NewGameViewModel = NewGameViewModel.init(playerCount: Constants.NumberOfPlayers.max)


    @IBOutlet weak var stepper: UIStepper! {
        didSet {
            self.stepperLabel.text = ("\(self.stepper.value) players")
        }
    }

    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.stepper.minimumValue = Double(Constants.NumberOfPlayers.min)
        self.stepper.maximumValue = Double(Constants.NumberOfPlayers.max)
        self.stepper.value = Double(self.viewModel.players.count)

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

    @IBAction func stepperValueDidChange(_ sender: UIStepper) {
        //let stepperValue = Int(self.stepper.value)
    }

    @IBAction func backBtnPressed(_ sender: UIButton) {

    }

    @IBAction func doneBtnPresed(_ sender: UIButton) {
    }

    // MARK: - Collection View

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: AddPlayerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPlayerCellReuseID", for: indexPath) as! AddPlayerCollectionViewCell

        let playerObj = viewModel.players[indexPath.row]
        let avatar = UIImage(named: playerObj.asset)
        cell.playerBtn.setImage(avatar, for: .normal)

        let onState = UIImage(named: "icon-bot2")
        let offState = UIImage(named: "icon-pawn")

        cell.isAISwitch.setImage(onState, for: .selected)
        cell.isAISwitch.setImage(offState, for: .normal)
        cell.isAISwitch.isSelected = playerObj.isAI

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
    }
    

}

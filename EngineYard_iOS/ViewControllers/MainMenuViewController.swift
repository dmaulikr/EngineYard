//
//  MainMenuViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class NewGameViewModel
{
    var game: Game = Game.instance

    private(set) var players:[Player] = [Player]()

    init() {
        setupPlayers(playerCount: Constants.NumberOfPlayers.max)

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

    private func setupPlayers(playerCount: Int) {
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
}

class MainMenuViewController: UIViewController {

    var viewModel: NewGameViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = NewGameViewModel.init()

        let winnerBtn: UIButton = UIButton(type: .system)
        winnerBtn.setTitle("Winner", for: .normal)
        winnerBtn.frame = CGRect(x: 100, y: 100, width: 150, height: 20)
        winnerBtn.tag = 0
        winnerBtn.addTarget(self, action: #selector(menuButtonPressed(_:)), for: .touchUpInside)

        let turnOrderBtn: UIButton = UIButton(type: .system)
        turnOrderBtn.setTitle("TurnOrder", for: .normal)
        turnOrderBtn.frame = CGRect(x: 100, y: 150, width: 150, height: 20)
        turnOrderBtn.tag = 1
        turnOrderBtn.addTarget(self, action: #selector(menuButtonPressed(_:)), for: .touchUpInside)

        self.view.addSubview(winnerBtn)
        self.view.addSubview(turnOrderBtn)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - IBAction

    @IBAction func menuButtonPressed(_ sender: UIButton) {

        guard let hasGame = self.viewModel?.game else {
            assertionFailure("No game object was created")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("No game board was created")
            return
        }


        switch sender.tag {
        case 0:
            // Launch Train View Controller
            let sb: UIStoryboard = UIStoryboard(name: "Winner", bundle: nil)
            if let controller = sb.instantiateViewController(withIdentifier: "WinnerViewController") as? WinnerViewController
            {
                controller.viewModel = WinnerViewModel.init(game: hasGame)
                self.present(controller, animated: true, completion: nil)
            }
            break

        case 1:
            let sb: UIStoryboard = UIStoryboard(name: "MarketDemands", bundle: nil)
            if let controller = sb.instantiateViewController(withIdentifier: "NewTurnOrderViewController") as? NewTurnOrderViewController
            {
                controller.viewModel = NewTurnOrderViewModel.init(game: hasGame)
                self.present(controller, animated: true, completion: nil)
            }
            break

        default:
            break
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}

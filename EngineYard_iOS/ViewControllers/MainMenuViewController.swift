//
//  MainMenuViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

fileprivate enum MainMenuTag: Int {
    case newGame = 0
    case taxes = 1
    case winner = 2
    case nextRound = 3
}

class MainMenuViewController: UIViewController {

    @IBOutlet var mainMenuBtnOutletCollection: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func mainMenuBtnPressed(_ sender: UIButton) {
        guard let tagSelected = MainMenuTag.init(rawValue: (sender).tag) else {
            return
        }

        let viewModel : NewGameViewModel = NewGameViewModel.init(playerCount: Constants.NumberOfPlayers.max)
        Game.setup(players: viewModel.players) { (game:Game?) in
            if let gameObj = game {
                Game.instance = gameObj
            }
        }

        switch tagSelected {
        case .newGame:
            self.performSegue(withIdentifier: "newGameSegue", sender: self)
            break
        case .taxes:
            self.performSegue(withIdentifier: "taxesSegue", sender: self)
            break
        case .winner:
            self.performSegue(withIdentifier: "winnerSegue", sender: self)
            break
        case .nextRound:
            self.performSegue(withIdentifier: "newTurnOrderSegue", sender: self)
            break
        }
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if (segue.identifier == "newGameSegue") {
            //let vc: NewGameViewController = segue.destination as! NewGameViewController
        }
    }


}

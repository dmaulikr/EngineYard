//
//  MainMenuViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit


class MainMenuViewController: UIViewController {

    @IBOutlet var menuBtnOutletCollection: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBAction

    @IBAction func menuButtonPressed(_ sender: UIButton) {

        switch sender.tag {

        case 0:
            self.performSegue(withIdentifier: "newGameSetupSegue", sender: self)
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

        let hasGame = Game.instance
        let vc : NewGameSetupViewController = (segue.destination as? NewGameSetupViewController)!
        vc.viewModel = NewGameViewModel.init(game: hasGame)

    }


}

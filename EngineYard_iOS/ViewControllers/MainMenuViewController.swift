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
    case leaderBoard = 1
    case settings = 2
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
        //self.viewModel.menuButtonPressed(tag: (sender).tag)
        guard let tagSelected = MainMenuTag.init(rawValue: (sender).tag) else {
            return
        }

        switch tagSelected {
        case .newGame:
            self.performSegue(withIdentifier: "newGameSegue", sender: self)
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

        if (segue.identifier == "newGameSegue") {
            //let vc: NewGameViewController = segue.destination as! NewGameViewController
        }
    }


}

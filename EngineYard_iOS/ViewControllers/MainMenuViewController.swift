//
//  MainMenuViewController.swift
//  EngineYard
//
//  Created by Amarjit on 25/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

struct MainMenuViewModel {
    enum MainMenuTag: Int {
        case newGameTag = 0
    }

    func menuButtonPressed(tag: Int) {
        guard let tagSelected = MainMenuTag.init(rawValue: tag) else {
            return
        }
        switch tagSelected {
        case .newGameTag:
            break
        }
    }
}

class MainMenuViewController: UIViewController {

    @IBOutlet var mainMenuBtnOutletCollection: [UIButton]!

    var viewModel : MainMenuViewModel = MainMenuViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func mainMenuBtnPressed(_ sender: UIButton) {
        self.viewModel.menuButtonPressed(tag: (sender).tag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

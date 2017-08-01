//
//  NewGameSetupViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class NewGameViewModel : BaseViewModel
{
    
}

class NewGameSetupViewController: UIViewController {

    var viewModel: NewGameViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        print (self.viewModel?.game?.description as Any)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        guard let hasGame = self.viewModel?.game else {
            return
        }

        guard let _ = hasGame.gameBoard else {
            assertionFailure("No gameboard defined")
            return
        }
        
        if (segue.identifier == "") {
            
        }
    }


}

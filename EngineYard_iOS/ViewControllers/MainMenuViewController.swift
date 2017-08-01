//
//  MainMenuViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

        switch sender.tag {
        case 0:
            // Launch Train View Controller
            let sb: UIStoryboard = UIStoryboard(name: "Winner", bundle: nil)
            if let controller = sb.instantiateViewController(withIdentifier: "WinnerViewController") as? WinnerViewController
            {
                self.present(controller, animated: true, completion: nil)
            }
            break

        case 1:
            let sb: UIStoryboard = UIStoryboard(name: "MarketDemands", bundle: nil)
            if let controller = sb.instantiateViewController(withIdentifier: "NewTurnOrderViewController") as? NewTurnOrderViewController
            {
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

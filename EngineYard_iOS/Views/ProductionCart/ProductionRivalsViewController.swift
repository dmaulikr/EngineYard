//
//  ProductionRivalsViewController.swift
//  EngineYard
//
//  Created by Amarjit on 17/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class ProductionRivalsViewController: UIViewController {

    weak var viewModel : BuyProductionDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hasViewModel = self.viewModel else {
            return 0
        }
        guard let hasRivals = hasViewModel.rivals else {
            return 0
        }
        return hasRivals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RivalTrainOwnersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RivalTrainOwnersTableViewCell", for: indexPath) as! RivalTrainOwnersTableViewCell

        guard let hasViewModel = self.viewModel else {
            return cell
        }

        hasViewModel.configureWithCell(cell: cell, atIndexPath: indexPath)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
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

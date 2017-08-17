//
//  ProductionRivalsViewController.swift
//  EngineYard
//
//  Created by Amarjit on 17/08/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class ProductionRivalsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var rivalsTableView: UITableView!
    var rivals: [Player]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.rivalsTableView.register(UINib(nibName: "RivalTrainOwnersTableViewCell", bundle: nil), forCellReuseIdentifier: "RivalTrainOwnersTableViewCell")
        self.rivalsTableView.delegate = self
        self.rivalsTableView.dataSource = self
        self.rivalsTableView.allowsSelection = false
        self.rivalsTableView.allowsMultipleSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableView delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let hasRivals = rivals else {
            return 0
        }
        return hasRivals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RivalTrainOwnersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RivalTrainOwnersTableViewCell", for: indexPath) as! RivalTrainOwnersTableViewCell

        /*
        guard let hasRivals = rivals else {
            return cell
        }
        */

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
    }

    

}

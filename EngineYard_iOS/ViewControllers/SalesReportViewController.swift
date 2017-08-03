//
//  SalesReportViewController.swift
//  EngineYard
//
//  Created by Amarjit on 31/07/2017.
//  Copyright © 2017 Amarjit. All rights reserved.
//

import UIKit

class SalesReportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var viewModel: SalesReportViewModel?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "SalesTableViewCell", bundle: nil), forCellReuseIdentifier: "SalesTableViewCell")
        //self.tableView.register(SalesTableViewCell.self, forCellReuseIdentifier: "SalesTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        self.tableView.allowsMultipleSelection = false
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        //self.tableView.estimatedRowHeight = 70

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - IBActions

    @IBAction func doneBtnPressed(_ sender: UIButton) {
        let identifier = "taxReportSegue"
        if (self.shouldPerformSegue(withIdentifier: identifier, sender: self)) {
            self.performSegue(withIdentifier: identifier, sender: self)
        }
    }

    // MARK: - UITableView delegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SalesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SalesTableViewCell", for: indexPath) as! SalesTableViewCell

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        guard let hasViewModel = self.viewModel else {
            return false
        }
        guard let hasGame = hasViewModel.game else {
            return false
        }
        guard let _ = hasGame.gameBoard else {
            return false
        }

        return true
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        guard let hasGame = self.viewModel?.game else {
            assertionFailure("** No game object defined **")
            return
        }
        guard let _ = hasGame.gameBoard else {
            assertionFailure("** No game board defined **")
            return
        }

        if (segue.identifier == "taxReportSegue") {
            let vc : TaxReportViewController = (segue.destination as? TaxReportViewController)!
            vc.viewModel = TaxReportViewModel.init(game: hasGame)
        }
    }


}

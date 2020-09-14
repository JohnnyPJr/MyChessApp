//
//  ChessTableViewController.swift
//  MyChessApp
//
//  Created by John Platsis on 13/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class ChessTableViewController: UIViewController {

    var cellModelsToPresent: [ChessTableViewCellModel] = []
    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()

        if let _ = self.navigationController {
            setupNavigationBar()
        }

        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.rowHeight = UITableView.automaticDimension;
        self.tableview.separatorColor = UIColor.clear
    }

    // MARK: - Helper Methods

    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        self.navigationItem.title = String(describing: type(of: self))
    }

    func updateTableViewData() {
        registerNibNames()
        self.tableview.reloadData()
    }

    func registerNibNames() {
        for viewModel in cellModelsToPresent {
            tableview.register(UINib(nibName: viewModel.nibName(), bundle: Bundle.main),
                               forCellReuseIdentifier: viewModel.nibName())
        }
    }

    func appDisplayName() -> String {
        return "Chess"
    }
}

extension ChessTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModelsToPresent.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = cellModelsToPresent[indexPath.row]
        guard let cell = self.tableview.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier()) as? ChessTableViewCell else {
            NSLog("No cell found with reuse identifier", viewModel.reuseIdentifier())
            return UITableViewCell()
        }

        viewModel.updateView(cell: cell)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = cellModelsToPresent[indexPath.row]
        return viewModel.defaultHeightConstant
    }

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

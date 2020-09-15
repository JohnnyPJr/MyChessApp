//
//  ResultPathsVC.swift
//  MyChessApp
//
//  Created by John Platsis on 15/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class ResultPathsVC: ChessTableViewController {

    private var cellViewModels: [ChessTableViewCellModel]? = []
    private var results: [ChessPathsResultModel]?

    init(results: [ChessPathsResultModel]) {
        self.results = results
        super.init(nibName: "ChessTableViewController", bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if results?.count ?? 0 > 0 {
            setupNavigationBar()
            updateCellViewModels()
        } else {
            showNoResultsError()
        }
    }
    
    override func setupNavigationBar() {
        self.navigationItem.title = "Paths"
    }

    private func updateCellViewModels() {
        for resultModel in results ?? [] {
            let resultPathCellModel = ResultPathCellModel.init(resultModel)
            cellViewModels?.append(resultPathCellModel)
        }

        cellModelsToPresent = cellViewModels ?? []
        self.updateTableViewData()
    }

    private func showNoResultsError() {
        let alert = UIAlertController(title: self.appDisplayName(),
                                      message: "It looks like there are no paths for the chosen destination.\n Try again",
                                      preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Go Back",
                                        style: .default,
                                        handler: { [weak self] _ in
                                            guard let strongSelf = self else { return }
                                            strongSelf.navigationController?.popViewController(animated: false)
        })

        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
}

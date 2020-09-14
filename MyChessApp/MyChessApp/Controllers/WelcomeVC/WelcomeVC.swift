//
//  WelcomeVC.swift
//  MyChessApp
//
//  Created by John Platsis on 14/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class WelcomeVC: ChessTableViewController, ChessViewModelTextfieldDelegate, ChessViewModelButtonDelegate{

    private var cellViewModels: [ChessTableViewCellModel]? = []
    private var chessModel: ChessModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCellViewModels()

        chessModel = ChessModel.init(size: 0,
                                     sourcePosition: nil,
                                     destinationPosition: nil,
                                     results: nil)
    }

    override func setupNavigationBar() {
        self.navigationItem.title = "Welcome"
    }

    private func updateCellViewModels() {

        let welcomeCellModel = WelcomeCellModel.init(self)
        welcomeCellModel.cellModelIdentifier = "WELCOME_CELL"
        cellViewModels?.append(welcomeCellModel)

        cellModelsToPresent = cellViewModels ?? []

        self.updateTableViewData()
    }

    // MARK: - ChessViewModelButtonDelegate Delegate
    func didTappedButton(_ sender: UIButton, cellModelIdentifier: String) {
        if cellModelIdentifier == "WELCOME_CELL" {
            if inputsAreValid() == true,
                let data = chessModel {
                let vc = ChessCollectionViewController.init(data: data)
                self.navigationController?.pushViewController(vc, animated: false)
            } else {
                let alert = UIAlertController(title: self.appDisplayName(),
                                              message: "Something Went Wrong. \nTry Again!",
                                              preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in })
                alert.addAction(alertAction)
                self.present(alert, animated: true)

            }
        }
    }

    // MARK: - Helper Methods

    func inputsAreValid() -> Bool {
        if chessModel?.size ?? 0 >= 6 && chessModel?.size ?? 0 <= 16 {
            return true
        } else {

            let alert = UIAlertController(title: self.appDisplayName(),
                                          message: "You should give a value between 6 and 16. \nTry Again!",
                                          preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in })
            alert.addAction(alertAction)
            self.present(alert, animated: true)

            return false
        }
    }

    // MARK: - ChessViewModelTextfieldDelegate Delegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, cellModelIdentifier: String) -> Bool {
        if cellModelIdentifier == "WELCOME_CELL" {
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if let sizeInput = Int(newString) {
                chessModel?.size = sizeInput
            } else {
                chessModel?.size = 0
            }

            return true
        }

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, cellModelIdentifier: String) {
        if cellModelIdentifier == "WELCOME_CELL" {
            if let sizeInput = Int(textField.text ?? "") {
                chessModel?.size = sizeInput
            } else {
                chessModel?.size = 0
            }
        }
    }
}

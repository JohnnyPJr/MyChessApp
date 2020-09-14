//
//  WelcomeVC.swift
//  MyChessApp
//
//  Created by John Platsis on 14/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class WelcomeVC: ChessTableViewController, ChessViewModelTextfieldDelegate, ChessViewModelButtonDelegate{

//    private var selectionData: LoginSelectionModel = LoginSelectionModel()
    private var cellViewModels: [ChessTableViewCellModel]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        updateCellViewModels()
    }

    override func setupNavigationBar() {
        self.navigationItem.title = ""
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
            if inputsAreValid() == true {
//                MBProgressHUD.showAdded(to: view, animated: true)

            }
        }
    }

    // MARK: - Helper Methods

    func inputsAreValid() -> Bool {
//        if selectionData.email?.count ?? 0 > 0,
//            selectionData.password?.count ?? 0 > 0 {
//            return true
//        } else {
//
//            let alert = UIAlertController(title: self.appDisplayName(),
//                                          message: "All fields are mandatory",
//                                          preferredStyle: .alert)
//            let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in })
//            alert.addAction(alertAction)
//            self.present(alert, animated: true)
//
//            return false
//        }
        return false
    }

    // MARK: - ChessViewModelTextfieldDelegate Delegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, cellModelIdentifier: String) -> Bool {
//        if cellModelIdentifier == "USERNAME_TYPE_CELL" {
//            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//            selectionData.email = newString
//            return true
//        }
//
//        if cellModelIdentifier == "PASSWORD_TYPE_CELL" {
//            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//            selectionData.password = newString
//            return true
//        }

        return false
    }

    func textFieldDidEndEditing(_ textField: UITextField, cellModelIdentifier: String) {
        if cellModelIdentifier == "WELCOME_CELL" {
//            selectionData.email = textField.text
        }

        if cellModelIdentifier == "WELCOME_CELL" {
//            selectionData.password = textField.text
        }
    }
}

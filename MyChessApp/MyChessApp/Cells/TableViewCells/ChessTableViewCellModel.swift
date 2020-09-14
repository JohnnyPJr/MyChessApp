//
//  ChessTableViewCellModel.swift
//  MyChessApp
//
//  Created by John Platsis on 13/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

public protocol ChessViewModelTextfieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, cellModelIdentifier: String)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, cellModelIdentifier: String) -> Bool
}

public protocol ChessViewModelButtonDelegate {
    func didTappedButton(_ sender: UIButton, cellModelIdentifier: String)
}

class ChessTableViewCellModel: NSObject, UITextFieldDelegate {
     var cellModelIdentifier: String?
        var defaultHeightConstant: CGFloat = 44.0
        var textFieldDelegate: ChessViewModelTextfieldDelegate?
        var buttonDelegate: ChessViewModelButtonDelegate?

        override init() {
            super.init()
        }

        func reuseIdentifier() -> String
        {
            if (String(describing: type(of: self)).hasSuffix("Model")) {
                return self.description.replacingOccurrences(of: "Model", with: "")
            }
            return ""
        }

        func nibName() -> String
        {
            if (String(describing: type(of: self)).hasSuffix("Model")) {
                return String(describing: type(of: self)).replacingOccurrences(of: "Model", with: "")
            }
            return ""
        }

        func updateView(cell: ChessTableViewCell) {

        }
    }

    extension ChessTableViewCellModel {
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let delegate = textFieldDelegate {
                return delegate.textField(textField, shouldChangeCharactersIn: range, replacementString: string, cellModelIdentifier: cellModelIdentifier ?? "")
            }
            return false
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            if let delegate = textFieldDelegate {
                delegate.textFieldDidEndEditing(textField, cellModelIdentifier: cellModelIdentifier ?? "")
            }
        }
    }

    extension ChessTableViewCellModel {
        @objc func handleButtonTap(sender: UIButton){
            if let delegate = buttonDelegate {
                delegate.didTappedButton(sender, cellModelIdentifier: cellModelIdentifier ?? "")
            }
        }
}

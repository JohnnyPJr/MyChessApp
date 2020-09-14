//
//  WelcomeCellModel.swift
//  MyChessApp
//
//  Created by John Platsis on 14/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class WelcomeCellModel: ChessTableViewCellModel {

    override init() {
        super.init()
        defaultHeightConstant = 388
    }

    convenience init(_ delegate: ChessViewModelTextfieldDelegate & ChessViewModelButtonDelegate) {
        self.init()

        self.textFieldDelegate = delegate
        self.buttonDelegate = delegate
    }
    override func nibName() -> String {
        return "WelcomeCell"
    }

    override func reuseIdentifier() -> String {
        return "WelcomeCell"
    }

    override func updateView(cell: ChessTableViewCell) {
        guard let view = cell as? WelcomeCell else {
            return
        }

        view.chessTextfield.delegate = self
        view.doneButton.addTarget(self, action:#selector(handleButtonTap(sender:)), for: .touchUpInside)
    }
}

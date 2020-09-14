//
//  ResultPathCellModel.swift
//  MyChessApp
//
//  Created by John Platsis on 15/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class ResultPathCellModel: ChessTableViewCellModel {

    override init() {
        super.init()
        defaultHeightConstant = 66
    }

    convenience init(_ resultModel: ChessPathsResultModel) {
        self.init()
    }
    override func nibName() -> String {
        return "ResultPathCell"
    }

    override func reuseIdentifier() -> String {
        return "ResultPathCell"
    }

    override func updateView(cell: ChessTableViewCell) {
        guard let view = cell as? ResultPathCell else {
            return
        }
    }
}

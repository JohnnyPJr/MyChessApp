//
//  ChessCollectionViewCell.swift
//  MyChessApp
//
//  Created by John Platsis on 13/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class ChessCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var positionInfo: UILabel!
    @IBOutlet weak var knightImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

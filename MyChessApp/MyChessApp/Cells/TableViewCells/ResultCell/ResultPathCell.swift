//
//  ResultPathCell.swift
//  MyChessApp
//
//  Created by John Platsis on 15/9/20.
//  Copyright © 2020 IPV. All rights reserved.
//

import UIKit

class ResultPathCell: ChessTableViewCell {
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var resultPathLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

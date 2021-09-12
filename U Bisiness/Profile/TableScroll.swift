//
//  Cell.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 20.08.2021.
//

import UIKit

class TableScroll: UITableViewCell {
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var protocolCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleCell.adjustsFontSizeToFitWidth = true
        protocolCell.adjustsFontSizeToFitWidth = true
    }
}

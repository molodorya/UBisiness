//
//  CellEvent.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 11.08.2021.
//

import UIKit

class EventCell: UICollectionViewCell {
    @IBOutlet weak var imageCollection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollection.layer.cornerRadius = 15
        imageCollection.image = UIImage.init(named: "crimea")
    }
}



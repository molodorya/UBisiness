//
//  CellNews.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 11.08.2021.
//

import UIKit

class CellNews: UICollectionViewCell {
    
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = 5
    }
    
    @IBAction func buttonMoreDetails(_ sender: UIButton) {
        print("more details")
    }
    
    
}

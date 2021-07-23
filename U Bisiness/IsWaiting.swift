//
//  IsWaiting.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 08.04.2021.
//

import UIKit

class IsWaiting: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        bounceScroll(scrollView: scrollView)
        
    }
}

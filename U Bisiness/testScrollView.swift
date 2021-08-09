//
//  testScrollView.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 05.08.2021.
//

import UIKit

class testScrollView: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bounceScroll(scrollView: scrollView)
    }
}

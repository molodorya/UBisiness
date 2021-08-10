//
//  OnBoardThree.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 06.04.2021.
//

import UIKit

class OnBoardThree: UIViewController, UIGestureRecognizerDelegate {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    

    @IBOutlet weak var imageEllipse: UIImageView!
    @IBOutlet weak var imageBisiness: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var oneBoard: UIView!
    @IBOutlet weak var twoBoard: UIView!
    @IBOutlet weak var threeBoard: UIView!
    @IBOutlet weak var nowScreen: UIView!
    @IBOutlet weak var fourBoard: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Invisible navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        // Set color buttom back in black
        navigationItem.backBarButtonItem?.tintColor = .black
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        bounceScroll(scrollView: scrollView)
        
        settingImageEllipse()
        settingImageBisiness()
        settingLabel()
        settingProgressBar()
    }
    
    private func settingImageEllipse() {
        imageEllipse.layer.borderWidth = 0
        imageEllipse.layer.borderColor = UIColor.lightGray.cgColor
        imageEllipse.layer.cornerRadius = 0
        imageEllipse.contentMode = .scaleAspectFill
        imageEllipse.clipsToBounds = true
        imageEllipse.backgroundColor = .clear
    }
    
    private func settingImageBisiness() {
        imageBisiness.layer.borderWidth = 0
        imageBisiness.layer.borderColor = UIColor.lightGray.cgColor
        imageBisiness.layer.cornerRadius = 0
        imageBisiness.contentMode = .scaleAspectFill
        imageBisiness.clipsToBounds = true
        imageBisiness.backgroundColor = .clear
    }
    
    private func settingLabel() {
        label.textAlignment = .center
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "ВСТРЕЧИ С ЭКСПЕРТАМИ ПО АКТУАЛЬНЫМ НАПРАВЛЕНИЯМ РАЗВИТИЯ БИЗНЕСА"
        label.backgroundColor = .clear
    }
    
    private func settingProgressBar() {
         nowScreen.backgroundColor = .black
         nowScreen.layer.cornerRadius = 4
         nowScreen.rotate(radians: -165.83)
         nowScreen.clipsToBounds = true
         
         
         oneBoard.rotate(radians: -165.83)
         oneBoard.layer.cornerRadius = 4
         
         twoBoard.rotate(radians: -165.83)
         twoBoard.layer.cornerRadius = 4
         
         threeBoard.rotate(radians: -165.83)
         threeBoard.layer.cornerRadius = 4
         
         fourBoard.rotate(radians: -165.83)
         fourBoard.layer.cornerRadius = 4
     }
}
 

 

 


  
 
 

 
 


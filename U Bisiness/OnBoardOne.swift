//
//  OnBoardOne.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 04.04.2021.
//

import UIKit



class OnBoardOne: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    

    @IBOutlet weak var imageEllipse: UIImageView!
    @IBOutlet weak var imageBisiness: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var onBoard: UIView!
    @IBOutlet weak var nowScreen: UIView!
    @IBOutlet weak var twoBoard: UIView!
    @IBOutlet weak var threeBoard: UIView!
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
        
        view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 244/255, alpha: 1.0)
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        bounceScroll(scrollView: scrollView)
       
        
        settingLabel()
        settingImageEllipse()
        settingImageBisiness()
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
        imageBisiness.contentMode = .scaleAspectFit
        imageBisiness.clipsToBounds = true
        imageBisiness.backgroundColor = .clear
    }
    
    
    private func settingLabel() {
        label.textAlignment = .center
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Helvetica", size: 20)
        label.text = "ЗНАКОМСТВО И ОБЩЕНИЕ\n С ПРЕДПРИНИМАТЕЛЯМИ\n СО ВСЕГО МИРА"
        label.backgroundColor = .clear
    }
    
    private func settingProgressBar() {
        nowScreen.backgroundColor = .black
        nowScreen.layer.cornerRadius = 4
        nowScreen.rotate(radians: -165.83)
        nowScreen.clipsToBounds = true

        onBoard.rotate(radians: -165.83)
        onBoard.layer.cornerRadius = 4
        
        twoBoard.rotate(radians: -165.83)
        twoBoard.layer.cornerRadius = 4
        
        threeBoard.rotate(radians: -165.83)
        threeBoard.layer.cornerRadius = 4
        
        fourBoard.rotate(radians: -165.83)
        fourBoard.layer.cornerRadius = 4
    }
}



















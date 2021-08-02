//
//  ProfileMenu.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 16.06.2021.
//

import UIKit


class ProfileMenuView: UIView {
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 67, height: 122))
        UIColor.init(red: 149/255, green: 209/255, blue: 187/255, alpha: 0.60).setFill()
        path.fill()
    }
}

class ProfileMenu: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileViewMyСabinet: ProfileMenuView!
    @IBOutlet weak var buttonMyCabinet: UIButton!
    @IBOutlet weak var logoMyCabinet: UIImageView!
    @IBOutlet weak var titleMyCabinet: UILabel!
    
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var subscribeControlButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        
        profileViewMyСabinet.backgroundColor = .clear
        profileViewMyСabinet.rotate(degrees: 38)
   
        logoMyCabinet.rotate(degrees: -38)
        titleMyCabinet.rotate(degrees: -38)
        
        self.scrollView.contentSize.height = 1500
        scrollView.backgroundColor = UIColor.vanillaWhite
        avatarUser.layer.cornerRadius = self.avatarUser.bounds.size.width / 2.0
        
        contentView.backgroundColor = UIColor.vanillaWhite
        headerView.backgroundColor = UIColor.vanillaWhite
        nameView.backgroundColor = UIColor.vanillaWhite
        emailView.backgroundColor = UIColor.vanillaWhite
        phoneView.backgroundColor = UIColor.vanillaWhite
        languageView.backgroundColor = UIColor.vanillaWhite
        
        settingEditButton()
        settingSubscribeControlButton()
        settingButtonMyCabinet()
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 200)

        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    
    
    @objc func didTapMenuButton() {
        print("lines")
        
      
    }
    
    @objc func user() {
        print("user")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    func settingButtonMyCabinet() {
        buttonMyCabinet.rotate(degrees: -38)
        buttonMyCabinet.backgroundColor = .clear
        
    }
    
    
    
    
    func settingEditButton() {
        
        editButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        editButton.layer.cornerRadius = 5
        editButton.layer.borderWidth = 2
    }
    
    func settingSubscribeControlButton() {
        subscribeControlButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        subscribeControlButton.layer.cornerRadius = 5
        subscribeControlButton.layer.borderWidth = 2
        
        
    }
  
}

//
//  EditSubscription.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 18.06.2021.
//

import UIKit

class EditSubscriptionView: UIView {
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 67, height: 122))
        UIColor.init(red: 149/255, green: 209/255, blue: 187/255, alpha: 0.60).setFill()
        path.fill()
    }
}



class EditSubscription: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var profileViewMyСabinet: EditSubscriptionView!
    @IBOutlet weak var logoMyCabinet: UIImageView!
    @IBOutlet weak var titleMyCabinet: UILabel!
  
    @IBOutlet weak var buttonMyCabinet: UIButton!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var subscribeStatus: UIView!
    @IBOutlet weak var historySell: UIView!
    
    
    @IBOutlet weak var buttonExtend: UIButton!
    @IBOutlet weak var buttonChange: UIButton!
    @IBOutlet weak var buttonCancelSubscribe: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileViewMyСabinet.backgroundColor = .clear
        profileViewMyСabinet.rotate(degrees: 38)
        logoMyCabinet.rotate(degrees: -38)
        titleMyCabinet.rotate(degrees: -38)
        
   
        buttonExtend.layer.cornerRadius = 5

        buttonChange.layer.cornerRadius = 5
        buttonChange.layer.borderWidth = 2
        
        
        
        view.backgroundColor = UIColor.vanillaWhite
        scrollView.backgroundColor = UIColor.vanillaWhite
        headerView.backgroundColor = UIColor.vanillaWhite
        historySell.backgroundColor = UIColor.vanillaWhite
        contentView.backgroundColor = UIColor.vanillaWhite
        
        settingButtonMyCabinet()
        settingSubscribeStatus()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
            navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
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
    
    func settingSubscribeStatus() {
        subscribeStatus.backgroundColor = UIColor(red: 255/255, green: 239/255, blue: 227/255, alpha: 1)
        subscribeStatus.layer.cornerRadius = 10

    }

}

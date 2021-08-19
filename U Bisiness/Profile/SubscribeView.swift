//
//  SubscribeView.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 19.08.2021.
//

import UIKit

class SubscribeView: UIViewController {

    
    // Navigations menu
    @IBOutlet weak var headerTextCabinet: UILabel!
    @IBOutlet weak var headerButtonCabinet: UIButton!
    
    // Card
    @IBOutlet weak var headerTextCard: UILabel!
    @IBOutlet weak var headerButtonCard: UIButton!
    
    // Offer
    @IBOutlet weak var headerTextOffer: UILabel!
    @IBOutlet weak var headerButtonOffer: UIButton!
    
    // Views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var headerCard: UIView!
    
    // Content
    @IBOutlet weak var extend: UIButton!
    @IBOutlet weak var change: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cabinet
        headerTextCabinet.adjustsFontSizeToFitWidth = true
        headerTextCabinet.text = "мой\nкабинет"
        headerButtonCabinet.backgroundColor = .clear
        
        // Card
        headerTextCard.adjustsFontSizeToFitWidth = true
        headerTextCard.text = "моя\nвизитка"
        headerButtonCard.backgroundColor = .clear
        
        //Offer
        headerTextCabinet.adjustsFontSizeToFitWidth = true
        headerTextOffer.text = "мои спец.\nпредложения"
        headerButtonOffer.backgroundColor = .clear
        
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        cardView.backgroundColor = .vanillaWhite
        headerCard.backgroundColor = .vanillaWhiteContrast
        
        scrollView.alwaysBounceVertical = true
        extend.layer.cornerRadius = 5
        change.backgroundColor = .clear
        change.layer.borderWidth = 2
        change.layer.borderColor = UIColor.black.cgColor
        change.layer.cornerRadius = 5
        
    }
    
    // Navigator menu
    @IBAction func actionCabinet(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingProfile")
        setSubView(vc!)
    }
    
    @IBAction func actionCard(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingCard")
        setSubView(vc!)
    }
    
    @IBAction func actionOffer(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingOffer")
        setSubView(vc!)
    }
    
    
    // Buttons
    @IBAction func actionExtend(_ sender: UIButton) {
        print("actionExtend")
    }
    
    @IBAction func actionChange(_ sender: UIButton) {
        print("actionChange")
    }
    
    @IBAction func actionCancel(_ sender: UIButton) {
        print("actionCancel")
    }
}

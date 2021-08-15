//
//  OfferCard.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.08.2021.
//

import UIKit

class OfferCard: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    // Cabinet
    @IBOutlet weak var headerTextCabinet: UILabel!
    @IBOutlet weak var headerButtonCabinet: UIButton!
    
    // Card
    @IBOutlet weak var headerTextCard: UILabel!
    @IBOutlet weak var headerButtonCard: UIButton!
    
    // Offer
    @IBOutlet weak var headerTextOffer: UILabel!
    @IBOutlet weak var headerButtonOffer: UIButton!
    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewProtocol: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewText: UIView!
    
    @IBOutlet weak var nameText: UITextView!
    @IBOutlet weak var protocolText: UITextView!
    @IBOutlet weak var dateText: UITextView!
    @IBOutlet weak var textText: UITextView!
    
    @IBOutlet weak var top: UIButton!
    @IBOutlet weak var save: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 5
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
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
        
        
        viewName.backgroundColor = .vanillaWhite
        viewProtocol.backgroundColor = .vanillaWhite
        viewDate.backgroundColor = .vanillaWhite
        viewText.backgroundColor = .vanillaWhite
        
        nameText.backgroundColor = .vanillaWhite
        protocolText.backgroundColor = .vanillaWhite
        dateText.backgroundColor = .vanillaWhite
        textText.backgroundColor = .vanillaWhite
        
        top.layer.cornerRadius = 5
        save.layer.cornerRadius = 5
        
        top.layer.borderWidth = 2
        top.layer.borderColor = UIColor.black.cgColor
        
        let alertController = UIAlertController(title: "В разработке", message: nil, preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func topAction(_ sender: UIButton) {
    }
    
    @IBAction func topSave(_ sender: UIButton) {
    }
}

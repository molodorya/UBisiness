//
//  OfferPage.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 24.06.2021.
//

import UIKit

class OfferPage: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var hiddenContenView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    

    

    override func viewDidLoad() {
        super.viewDidLoad()


        colorVanilla(view: view, scrollView: scrollView, contentView: hiddenContenView)

        profileView.backgroundColor = .vanillaWhite
        container.backgroundColor = .vanillaWhite

        settingImage()
        settingLabel()
        centerLabel.text = "Скидка 10% на моторные масла"
        button.layer.cornerRadius = 5
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    
    
    
    @IBAction func buttonAction(_ sender: UIButton) {
        print("OfferPage")
    }
    

    
    func settingImage() {
        profileImageView.image = UIImage.init(named: "crimea")
    }

    func settingLabel() {
        label.text = TextBig.texting
        label.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.6)
        label.backgroundColor = .vanillaWhite
    }

    func setupViews() {
        scrollView.contentInsetAdjustmentBehavior = .never
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    
    
    
}

//
//  NewsPage.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 24.06.2021.
//

import UIKit

class NewsPage: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var hiddenContenView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        colorVanilla(view: view, scrollView: scrollView, contentView: hiddenContenView)
        
        profileView.backgroundColor = .vanillaWhite
        container.backgroundColor = .vanillaWhite
        
        
        settingImage()
        settingLabel()
        
        
        centerLabel.text = "Может ли самозанятый платить НПД c процентов по займу"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
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

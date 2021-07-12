//
//  OfferPage.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 24.06.2021.
//

import UIKit

class OfferPage: UIViewController {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
  
    @IBOutlet weak var titleContent: UILabel!
    @IBOutlet weak var dateContent: UILabel!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let linesImage = UIImage(systemName: "list.dash")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let userImage = UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: linesImage, style: .plain, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: userImage, style: .plain, target: self, action: nil)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

        settingTitleContent()
        settingDateContent()
        settingLabel()
        settingButton()
    }
    
    
    
    @IBAction func buttonTouch(_ sender: UIButton) {
        print("нажал")
    }
    


    
    func settingTitleContent() {
        titleContent.textColor = .white
        titleContent.textAlignment = .left
        titleContent.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func settingDateContent() {
        dateContent.textColor = .lightGray
        dateContent.textAlignment = .left
        dateContent.font = UIFont.systemFont(ofSize: 12)
    }
    
    func settingLabel() {
        label.numberOfLines = 0
        label.text = TextBig.textUI
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.6)
    }
    
    func settingButton() {
        button.layer.cornerRadius = 5
    }
    
    
    
  


}

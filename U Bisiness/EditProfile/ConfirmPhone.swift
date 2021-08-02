//
//  ConfirmPhone.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.07.2021.
//

import UIKit

class ConfirmPhone: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var numberLines: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        navigationItem.backBarButtonItem?.tintColor = .black
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        settingNumber()
    }
    
    
    @IBAction func actionButton(_ sender: UIButton) {
        print("actionButton")
    }
    
    
    func settingNumber() {
        numberView.backgroundColor = .vanillaWhite
        numberTextField.autocorrectionType = .no
    }
    
    func settingButton() {
        button.layer.cornerRadius = 5
    }
    
   
    
}

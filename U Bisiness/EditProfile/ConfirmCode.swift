//
//  ConfirmCode.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.07.2021.
//

import UIKit

class ConfirmCode: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var viewCode: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var lines: UIView!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
        navigationController?.isNavigationBarHidden = true
        

        settingCodeView()
        settingButton()
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        print("actionButton")
    }
    
    
    func settingCodeView() {
        viewCode.backgroundColor = .vanillaWhite
        textField.autocorrectionType = .no
    }
    
    func settingButton() {
        button.layer.cornerRadius = 5
    }
    
}

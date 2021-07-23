//
//  EditPassword.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.07.2021.
//

import UIKit

class EditPassword: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var oldView: UIView!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var oldLines: UIView!
    
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newLines: UIView!
    
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var confirmLines: UIView!
    
    
    @IBOutlet weak var button: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        bounceScroll(scrollView: scrollView)
        
        
        
        settingOldView()
        settingNewView()
        settingConfirmView()
        settingButton()
    }
    
    
    
    @IBAction func actionButton(_ sender: UIButton) {
        print("actionButton")
    }
    
    
    func settingOldView() {
        oldView.backgroundColor = .vanillaWhite
        oldPassword.autocorrectionType = .no
    }
    
    func settingNewView() {
        newView.backgroundColor = .vanillaWhite
        newPassword.autocorrectionType = .no
    }
    
    func settingConfirmView() {
        confirmView.backgroundColor = .vanillaWhite
        confirmPassword.autocorrectionType = .no
    }
    
    func settingButton() {
        button.layer.cornerRadius = 5
    }
    
    
    
}

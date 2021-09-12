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
        titleLabel.text = titleLabel.text?.uppercased()
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        navigationItem.backBarButtonItem?.tintColor = .black
        button.layer.cornerRadius = 5
        viewCode.backgroundColor = .vanillaWhite
        textField.autocorrectionType = .no
        
        let alertController = UIAlertController(title: "В разработке", message: nil, preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        print("actionButton")
    }
 
}

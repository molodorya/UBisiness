//
//  TabUserController.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 21.08.2021.
//

import UIKit

class TabUserController: UITabBarController {

   
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leftAction(.init())
    }
 
    @IBAction func leftAction(_ sender: UIBarButtonItem) {
        leftButton.target = revealViewController()
        leftButton.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    @IBAction func rightAction(_ sender: UIBarButtonItem) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "navSettings")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

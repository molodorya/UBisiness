//
//  LaunchScreen.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 15.08.2021.
//

import UIKit

class LaunchScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if UserDefaults.standard.bool(forKey: "Auth") == false {
            let vc = storyboard?.instantiateViewController(identifier: "Welcome")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
        } else {
            
        }
    }
}

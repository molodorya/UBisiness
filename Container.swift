//
//  Container.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 10.06.2021.
//

import UIKit

class Container: UIViewController {
    
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    
    let menuVC = Menu()
    let homeVC = Home()
    var navVC: UINavigationController?
    

    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        addChildVCs()
        
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { Timer in
            self.toggleMenu(completion: nil) // пример
        }
      
    }
    
    
    
    private func addChildVCs() {
        //Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        // Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
        
    }
}

extension Container: HomeSideDelegate {
    
    func didTapMenuButton() {
        toggleMenu(completion: nil)
        
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        
        switch menuState {
        case .closed:
            addAlert()// alert
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 68 //navVC на homeVC
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                  
                }
            }
            
        case .opened:
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}



extension Container: MenuDelegate {
    func didSelect(menuItem: Menu.MenuOptions) {
        toggleMenu(completion: nil)
        
        switch menuItem {
        case .personal: addInfo()
        case .card: break
        case .calendar: break
        case .gift:break
        case .news: break
        case .library:break
        case .photoLibrary:break
        case .aboutAs:break
        case .feedback:break
        case .home: resetToHome()
        }
        
    }
    
    func addInfo() {
//        let vc =
        
//        homeVC.addChild(vc)
//        homeVC.view.addSubview(vc.view)
//        vc.view.frame = view.frame
//        vc.didMove(toParent: homeVC)
    }
    
    func addAlert() {
        let alertController = UIAlertController(title: "SideMenu",
                                                message: "Не настроен. добавить изображение с фигмы и навигацию",
                                                preferredStyle: UIAlertController.Style.alert)
        let confirmAction = UIAlertAction(
            title: "OK", style: UIAlertAction.Style.default) { (action) in }
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func addNews() {
        let vc = News()
        
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
    }
    
    func resetToHome() {
//        infoVC.view.removeFromSuperview()
    }
    
}

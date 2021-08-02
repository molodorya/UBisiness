//
//  Welcome.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 02.04.2021.
//

import UIKit
import CoreLocation
import SwiftUI

class Welcome: UIViewController, CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var buttonEnglish: UIButton!
    @IBOutlet weak var buttonRussia: UIButton!
    @IBOutlet weak var buttonGermania: UIButton!
    

    @IBOutlet weak var nowScreen: UIView!
    @IBOutlet weak var onBoard: UIView!
    @IBOutlet weak var twoBoard: UIView!
    @IBOutlet weak var threeBoard: UIView!
    @IBOutlet weak var fourBoard: UIView!
    
    
    let locationManager = CLLocationManager()
    
    
    func settingLocationManager() {
        // Запрашиваем авторизацию у пользователя.
        self.locationManager.requestAlwaysAuthorization()
        
        // Для использования на переднем плане
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
           
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offLinesScroll(scrollView: scrollView)
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        locationManager.requestWhenInUseAuthorization()
        
        
        locationManager.stopUpdatingLocation()
        print("когда мы берем локацию у пользователя?")
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = UIColor(red: 255/255, green: 249/255, blue: 244/255, alpha: 1.0)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
      
        scrollView.alwaysBounceVertical = true
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)

        settingButtonEnglish()
        settingButtonRussia()
        settingButtonGermania()
        settingProgressBar()
    }
    
    
    private func settingProgressBar() {
        nowScreen.backgroundColor = .black
        nowScreen.layer.cornerRadius = 4
        nowScreen.rotate(radians: -165.83)
        nowScreen.clipsToBounds = true
        
        onBoard.rotate(radians: -165.83)
        onBoard.layer.cornerRadius = 4
        
        twoBoard.rotate(radians: -165.83)
        twoBoard.layer.cornerRadius = 4
        
        threeBoard.rotate(radians: -165.83)
        threeBoard.layer.cornerRadius = 4
        
        fourBoard.rotate(radians: -165.83)
        fourBoard.layer.cornerRadius = 4
    }
    
    
    
    @IBAction func actionEn(_ sender: UIButton) {
        buttonEnglish.backgroundColor = .black
        let attributes = NSAttributedString(string: "EN", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        buttonEnglish.setAttributedTitle(attributes, for: .normal)
    }
    
    @IBAction func actionRu(_ sender: UIButton) {
        buttonRussia.backgroundColor = .black
        let attributes = NSAttributedString(string: "RU", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        buttonRussia.setAttributedTitle(attributes, for: .normal)
    
        
        
    }
    
    @IBAction func actionDe(_ sender: UIButton) {
        buttonGermania.backgroundColor = .black
        let attributes = NSAttributedString(string: "RU", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        buttonGermania.setAttributedTitle(attributes, for: .normal)
    }
    
    
    private func settingButtonEnglish() {
        buttonEnglish.backgroundColor = .clear
        buttonEnglish.layer.cornerRadius = 15
        buttonEnglish.layer.borderColor = UIColor.black.cgColor
        buttonEnglish.layer.borderWidth = 1
        buttonEnglish.titleLabel?.font = UIFont(name: "Helvetica", size: 13)
        
        let attributes = NSAttributedString(string: "EN", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        buttonEnglish.setAttributedTitle(attributes, for: .normal)
    }
    
    
    private func settingButtonRussia() {
        buttonRussia.backgroundColor = .clear
        
        buttonRussia.layer.cornerRadius = 15
        buttonRussia.layer.borderColor = UIColor.black.cgColor
        buttonRussia.layer.borderWidth = 1
        buttonRussia.titleLabel?.font = UIFont(name: "Helvetica", size: 13)
        
        let attributes = NSAttributedString(string: "RU", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        buttonRussia.setAttributedTitle(attributes, for: .normal)
    }
    
    private func settingButtonGermania() {
        buttonGermania.backgroundColor = .clear
        buttonGermania.layer.cornerRadius = 15
        buttonGermania.translatesAutoresizingMaskIntoConstraints = false
        buttonGermania.layer.borderColor = UIColor.black.cgColor
        buttonGermania.layer.borderWidth = 1
        buttonGermania.titleLabel?.font = UIFont(name: "Helvetica", size: 13)
        buttonGermania.titleLabel?.text = "DE"
        
        let attributes = NSAttributedString(string: "DE", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        buttonGermania.setAttributedTitle(attributes, for: .normal)
    }
}


extension Welcome: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

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
    
    // View
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    // Content
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonEnglish: UIButton!
    @IBOutlet weak var buttonRussia: UIButton!
    @IBOutlet weak var buttonGermania: UIButton!
    
    // Progress bar
    @IBOutlet weak var nowScreen: UIView!
    @IBOutlet weak var onBoard: UIView!
    @IBOutlet weak var twoBoard: UIView!
    @IBOutlet weak var threeBoard: UIView!
    @IBOutlet weak var fourBoard: UIView!
    
    // Add location manager
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
    
    // Сalled when the controller is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Invisible navigation bar
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        // Add swipe delegate
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        // Preset color view
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
        // Bounce effect
        scrollView.alwaysBounceVertical = true
        
        // Call functions
        settingButtonEnglish()
        settingButtonRussia()
        settingButtonGermania()
        settingProgressBar()
    }

    // Called before the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopUpdatingLocation()
        print("когда мы берем локацию у пользователя?")
    }
    
    // Preset ProgressBar
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
    
    // Target action buttonEN
    @IBAction func actionEn(_ sender: UIButton) {
        buttonEnglish.backgroundColor = .black
        let attributes = NSAttributedString(string: "EN", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        buttonEnglish.setAttributedTitle(attributes, for: .normal)
    }

    // Target action buttonRU
    @IBAction func actionRu(_ sender: UIButton) {
        buttonRussia.backgroundColor = .black
        let attributes = NSAttributedString(string: "RU", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        buttonRussia.setAttributedTitle(attributes, for: .normal)
    }
    
    // Target action buttonDE
    @IBAction func actionDe(_ sender: UIButton) {
        buttonGermania.backgroundColor = .black
        let attributes = NSAttributedString(string: "RU", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        buttonGermania.setAttributedTitle(attributes, for: .normal)
    }

    // Preset buttonEN
    private func settingButtonEnglish() {
        buttonEnglish.backgroundColor = .clear
        buttonEnglish.layer.cornerRadius = 15
        buttonEnglish.layer.borderColor = UIColor.black.cgColor
        buttonEnglish.layer.borderWidth = 1
        buttonEnglish.titleLabel?.font = UIFont(name: "Helvetica", size: 13)

        let attributes = NSAttributedString(string: "EN", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        buttonEnglish.setAttributedTitle(attributes, for: .normal)
    }

    // Preset buttonRU
    private func settingButtonRussia() {
        buttonRussia.backgroundColor = .clear

        buttonRussia.layer.cornerRadius = 15
        buttonRussia.layer.borderColor = UIColor.black.cgColor
        buttonRussia.layer.borderWidth = 1
        buttonRussia.titleLabel?.font = UIFont(name: "Helvetica", size: 13)

        let attributes = NSAttributedString(string: "RU", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        buttonRussia.setAttributedTitle(attributes, for: .normal)
    }

    // Preset buttonDE
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

// Add swipe
extension Welcome: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}



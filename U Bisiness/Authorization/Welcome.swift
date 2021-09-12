//
//  testWelcome.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 10.08.2021.
//

import UIKit
import Foundation

class Welcome: UIViewController {
    
    // Views
    @IBOutlet weak var collectionView: UICollectionView!
    
    // Content
  
    @IBOutlet weak var stackViewProgressBar: UIStackView!
    @IBOutlet weak var one: UIView!
    @IBOutlet weak var two: UIView!
    @IBOutlet weak var three: UIView!
    @IBOutlet weak var four: UIView!
    @IBOutlet weak var five: UIView!
    
    static var statusButtons = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Color background
        view.backgroundColor = .vanillaWhite
        
        
        // Hidden navigation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Color collectionView
        collectionView.backgroundColor = .vanillaWhite
    
        // Delegates
        collectionView.delegate = self
        collectionView.dataSource = self
    
        // Flipping scroll
        self.collectionView.isPagingEnabled = true

        // Off scroll horizontal indicator
        collectionView.showsHorizontalScrollIndicator = false
        settingProgressBar()
        
        collectionView.isScrollEnabled = false
        stackViewProgressBar.isHidden = true
        
        
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { Timer in
            if Welcome.statusButtons == true {
                self.collectionView.isScrollEnabled = true
                self.stackViewProgressBar.isHidden = false
            }
        }
    }
    
    

    
    // Preset ProgressBar
    private func settingProgressBar() {
        one.backgroundColor = .black
        one.layer.cornerRadius = 4
        
        one.rotate(radians: -165.83)
        one.clipsToBounds = true

        two.rotate(radians: -165.83)
        two.layer.cornerRadius = 4

        three.rotate(radians: -165.83)
        three.layer.cornerRadius = 4

        four.rotate(radians: -165.83)
        four.layer.cornerRadius = 4
        
        five.rotate(radians: -165.83)
        five.layer.cornerRadius = 4
    }
}



class OnboardOne: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buttonEnglish: UIButton!
    @IBOutlet weak var buttonRussia: UIButton!
    @IBOutlet weak var buttonGermania: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.text = titleLabel.text?.uppercased()
        presetStartButtons(text: "EN", button: buttonEnglish, textColor: .black)
        presetStartButtons(text: "RU", button: buttonRussia, textColor: .black)
        presetStartButtons(text: "DE", button: buttonGermania, textColor: .black)
        
        // Preset buttons: ru, en, de
        buttonEnglish.backgroundColor = .clear
        buttonEnglish.layer.cornerRadius = 15
        buttonEnglish.layer.borderColor = UIColor.black.cgColor
        buttonEnglish.layer.borderWidth = 1
        buttonEnglish.titleLabel?.font = UIFont(name: "Helvetica", size: 13)
        
        buttonRussia.layer.cornerRadius = 15
        buttonRussia.layer.borderColor = UIColor.black.cgColor
        buttonRussia.layer.borderWidth = 1
        buttonRussia.titleLabel?.font = UIFont(name: "Helvetica", size: 13)
      
        buttonGermania.backgroundColor = .clear
        buttonGermania.layer.cornerRadius = 15
        buttonGermania.translatesAutoresizingMaskIntoConstraints = false
        buttonGermania.layer.borderColor = UIColor.black.cgColor
        buttonGermania.layer.borderWidth = 1
        buttonGermania.titleLabel?.font = UIFont(name: "Helvetica", size: 13)
        
        backgroundColor = .vanillaWhite
        
        let locale = NSLocale.preferredLanguages.first!
        
        if locale == "ru-RU" {
            actionRU(.init())
        } else if locale == "en-EN" {
            actionEN(.init())
        }
    }
    
    
    func atrButtons(button: UIButton, text: String, textColor: UIColor, background: UIColor) {
        let attributes = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        button.setAttributedTitle(attributes, for: .normal)
        button.backgroundColor = background
    }
    
    
   
    
 
    // Target action buttonEN
    @IBAction func actionEN(_ sender: UIButton) {
        atrButtons(button: buttonEnglish, text: "EN", textColor: .white, background: .black)
        atrButtons(button: buttonRussia, text: "RU", textColor: .black, background: .clear)
        atrButtons(button: buttonGermania, text: "DE", textColor: .black, background: .clear)
        
        UserDefaults.standard.set(["en-GB"], forKey: "AppleLanguages")
        UserDefaults.standard.setValue("en", forKey: "languageCustom")
        UserDefaults.standard.synchronize()
        
        
        Welcome.statusButtons = true
        
        
    }

    // Target action buttonRU
    @IBAction func actionRU(_ sender: UIButton) {
        atrButtons(button: buttonEnglish, text: "EN", textColor: .black, background: .clear)
        atrButtons(button: buttonRussia, text: "RU", textColor: .white, background: .black)
        atrButtons(button: buttonGermania, text: "DE", textColor: .black, background: .clear)
        
        UserDefaults.standard.set(["ru"], forKey: "AppleLanguages")
        UserDefaults.standard.setValue("ru", forKey: "languageCustom")
        UserDefaults.standard.synchronize()
        
        
        Welcome.statusButtons = true
     
    }
    
    // Target action buttonDE
    @IBAction func actionDE(_ sender: UIButton) {
        atrButtons(button: buttonEnglish, text: "EN", textColor: .black, background: .clear)
        atrButtons(button: buttonRussia, text: "RU", textColor: .black, background: .clear)
        atrButtons(button: buttonGermania, text: "DE", textColor: .white, background: .black)
        
        UserDefaults.standard.set(["de"], forKey: "AppleLanguages")
        UserDefaults.standard.setValue("de", forKey: "languageCustom")
        UserDefaults.standard.synchronize()
       
        
        
        Welcome.statusButtons = true
    
    }
    
    func presetStartButtons(text: String, button: UIButton, textColor: UIColor) {
        let attributes1 = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        button.setAttributedTitle(attributes1, for: .normal)
    }
}

class OnboardTwo: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        titleLabel.text = "ЗНАКОМСТВО И ОБЩЕНИЕ\n С ПРЕДПРИНИМАТЕЛЯМИ\n СО ВСЕГО МИРА"
        backgroundColor = .vanillaWhite
    }
}

class OnboardThree: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        titleLabel.text = "ВОЗМОЖНОСТЬ НАЙТИ\n БИЗНЕС-ПАРТНЕРОВ\n И МАСШТАБИРОВАТЬ\n БИЗНЕС"
        backgroundColor = .vanillaWhite
    }
}

class OnboardFour: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        titleLabel.text = "ВСТРЕЧИ С ЭКСПЕРТАМИ ПО АКТУАЛЬНЫМ НАПРАВЛЕНИЯМ РАЗВИТИЯ БИЗНЕСА"
        backgroundColor = .vanillaWhite
    }
}

extension Welcome: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Amount cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
        
    }
    
    // Сell size is equal to screen size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    
    // Spacing for section-cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
    // Page control
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let nowRoundedIndex = Int(round(index))
        
        switch nowRoundedIndex {
        case 0:
            one.backgroundColor = .black
            two.backgroundColor = .lightGray
            three.backgroundColor = .lightGray
            four.backgroundColor = .lightGray
        case 1:
            one.backgroundColor = .lightGray
            two.backgroundColor = .black
            three.backgroundColor = .lightGray
            four.backgroundColor = .lightGray
        case 2:
            one.backgroundColor = .lightGray
            two.backgroundColor = .lightGray
            three.backgroundColor = .black
            four.backgroundColor = .lightGray
        case 3:
            one.backgroundColor = .lightGray
            two.backgroundColor = .lightGray
            three.backgroundColor = .lightGray
            four.backgroundColor = .black
        case 4:
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SingIn")
            let navController = UINavigationController(rootViewController: viewController!)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
            
        default:
          break
        }
    }
    
    
    // Create cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cellOne = collectionView.dequeueReusableCell(withReuseIdentifier: "welcome", for: indexPath) as! OnboardOne
            
            return cellOne
        } else if indexPath.item == 1 {
            let cellTwo = collectionView.dequeueReusableCell(withReuseIdentifier: "welcomeTwo", for: indexPath) as! OnboardTwo
            return cellTwo
            
        } else if indexPath.item == 2 {
            let cellThree = collectionView.dequeueReusableCell(withReuseIdentifier: "welcomeThree", for: indexPath) as! OnboardThree
            return cellThree
            
        } else if indexPath.item == 3 {
            let cellFour = collectionView.dequeueReusableCell(withReuseIdentifier: "welcomeFour", for: indexPath) as! OnboardFour
            return cellFour
            
        } else if indexPath.item == 4 {
            let cellFive = collectionView.dequeueReusableCell(withReuseIdentifier: "welcomeFive", for: indexPath)
            cellFive.backgroundColor = .white
            return cellFive
            
        } else {
            let cellOne = collectionView.dequeueReusableCell(withReuseIdentifier: "welcome", for: indexPath) as! OnboardOne
            print("else block welcome")
            return cellOne
        }
    }
}

extension Bundle {
    private static var bundle: Bundle!

    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: "app_lang") ?? "ru"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }

        return bundle;
    }

    public static func setLanguage(lang: String) {
        UserDefaults.standard.set([lang], forKey: "app_lang")
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }

    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized(), arguments: arguments)
    }
}

//
//  ViewController.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 18.06.2021.
//

import UIKit



class EditProfileView: UIView {
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 67, height: 122))
        UIColor.init(red: 149/255, green: 209/255, blue: 187/255, alpha: 0.60).setFill()
        path.fill()
    }
}

class EditProfileMenu: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var editProfileView: EditProfileView!
    @IBOutlet weak var buttonMyCabinet: UIButton!
    @IBOutlet weak var logoMyCabinet: UIImageView!
    @IBOutlet weak var titleMyCabinet: UILabel!
    
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var linesEmailView: UIView!

    @IBOutlet weak var changeName: UITextField!
    @IBOutlet weak var changeEmail: UITextField!
    @IBOutlet weak var changePhone: UITextField!
    @IBOutlet weak var changeLanguage: UITextField!
    
    
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        editProfileView.backgroundColor = .clear
        editProfileView.rotate(degrees: 38)
        
        logoMyCabinet.rotate(degrees: -38)
        titleMyCabinet.rotate(degrees: -38)
        
        
        scrollView.backgroundColor = UIColor.vanillaWhite
        avatarUser.layer.cornerRadius = self.avatarUser.bounds.size.width / 2.0
        
        contentView.backgroundColor = UIColor.vanillaWhite
        headerView.backgroundColor = UIColor.vanillaWhite
        nameView.backgroundColor = UIColor.vanillaWhite
        emailView.backgroundColor = UIColor.vanillaWhite
        phoneView.backgroundColor = UIColor.vanillaWhite
        languageView.backgroundColor = UIColor.vanillaWhite
        
        settingEditButton()
        settingButtonMyCabinet()
        
       
        
        hideKeyboardWhenTappedScreen()
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 325)

        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
    }
    
    
    @objc func didTapMenuButton() {
        print("lines")
        
      
    }
    
    @objc func user() {
        print("user")
    }
    
    
    
    @IBAction func targetButtonMyCabinet(_ sender: UIButton) {
        print("targetButtonMyCabinet")
    }
    
   
    @IBAction func targetButtonMyCard(_ sender: UIButton) {
        print("targetButtonMyCard")
    }
    
    
    
    @IBAction func targetButtonSpecialOffer(_ sender: UIButton) {
        print("targetSpecialOffer")
    }
    
    func shakeView(_ shakeView: UIView) {
        let shake = CABasicAnimation(keyPath: "position")
        let xDelta = CGFloat(10)
        shake.duration = 0.10
        shake.repeatCount = 1
        shake.autoreverses = true

        let from_point = CGPoint(x: shakeView.center.x - xDelta, y: shakeView.center.y)
        let from_value = NSValue(cgPoint: from_point)

        let to_point = CGPoint(x: shakeView.center.x + xDelta, y: shakeView.center.y)
        let to_value = NSValue(cgPoint: to_point)

        shake.fromValue = from_value
        shake.toValue = to_value
        shake.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        shakeView.layer.add(shake, forKey: "position")
    }
    
    
    
    
    @IBAction func changeEmailDidBegin(_ sender: UITextField) {
        
        
    }
    
    @IBAction func changeEmailEditingDidEnd(_ sender: UITextField) {
        
        func isValidEmail(email: String) -> Bool {
            let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
            let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
            
            return emailTest.evaluate(with: email)
        }
        if isValidEmail(email: changeEmail.text ?? "Error") {
            print("isValidEmail")
        } else {
            print("noValidEmail")
            self.changeEmail.text = nil
            self.changeEmail.placeholder = "Неверный E-mail"
            shakeView(linesEmailView)
            vibrationFunc(tapping: .light)
            linesEmailView.clipsToBounds = true
            UIView.animate(withDuration: 0) {
                self.linesEmailView.backgroundColor = UIColor.red
            } completion: { _ in
                UIView.animate(withDuration: 2) {
                    self.linesEmailView.backgroundColor = UIColor.black
                }
            }
        }
        
    }
    
    
    
    @IBAction func changePhoneEditingChanged(_ sender: UITextField) {
        
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

                guard let text = changePhone.text else { return false }
                let newString = (text as NSString).replacingCharacters(in: range, with: string)
                textField.text = formatPhoneNumber(number: newString)

                return false

        }
        
        func formatPhoneNumber(number: String) -> String {
            
            let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            let mask = "+X (XXX) XXX-XX-XX"
            var result = ""
            var index = cleanPhoneNumber.startIndex
            
            for ch in mask where index < cleanPhoneNumber.endIndex {
                if ch == "X" {
                    result.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            return result
        }
        
         func removeNumberFormat(number: String) -> String {
                let digits = CharacterSet.decimalDigits
                var text = ""
            
                for char in number.unicodeScalars {
                    if digits.contains(char) {
                        text.append(char.description)
                    }
                }
            
                return text
            }

        let a = changePhone.text! // Ну тут всегда текст должен быть?
//        let serverPhone = removeNumberFormat(number: a) // Отправка на сервер типа 79267536695

        changePhone.text = formatPhoneNumber(number: a)
      
    }
    
   

    
    @IBAction func saveButtonTouch(_ sender: UIButton) {
        
        print("""
                        \(changeName.text ?? "error")
                        \(changeEmail.text ?? "error")
                        \(changePhone.text ?? "error")
                        \(changeLanguage.text ?? "error")
            """)
        
    }
    
    
    
    
    
    
    
    
    func settingButtonMyCabinet() {
        buttonMyCabinet.rotate(degrees: -38)
        buttonMyCabinet.backgroundColor = .clear
        
    }
    
    
    
    
    func settingEditButton() {
        
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        saveButton.layer.cornerRadius = 5
    }
}

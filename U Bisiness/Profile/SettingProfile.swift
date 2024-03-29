//
//  SettingProfile.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 15.07.2021.
//
import UIKit

struct Profile: Codable {
    var email, name, tel, lang: String?
    var idUser: Int?
    var avatarurl: String?
}

class SettingProfile: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var setting: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    // Cabinet
    @IBOutlet weak var headerTextCabinet: UILabel!
    @IBOutlet weak var headerButtonCabinet: UIButton!
    
    // Card
    @IBOutlet weak var headerTextCard: UILabel!
    @IBOutlet weak var headerButtonCard: UIButton!
    
    // Offer
    @IBOutlet weak var headerTextOffer: UILabel!
    @IBOutlet weak var headerButtonOffer: UIButton!
    
    func headerPreset() {
        // Cabinet
        headerTextCabinet.adjustsFontSizeToFitWidth = true
//        headerTextCabinet.text = "мой\nкабинет"
        headerButtonCabinet.backgroundColor = .clear
        
        // Card
        headerTextCard.adjustsFontSizeToFitWidth = true
//        headerTextCard.text = "моя\nвизитка"
        headerButtonCard.backgroundColor = .clear
        
        //Offer
        headerTextCabinet.adjustsFontSizeToFitWidth = true
//        headerTextOffer.text = "мои спец.\nпредложения"
        headerButtonOffer.backgroundColor = .clear
    }
 
    
    //MARK: - MyCabinet View's
    @IBOutlet weak var cabinetView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameText: UITextView!
    @IBOutlet weak var nameLines: UIView!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var emailText: UITextView!
    @IBOutlet weak var emailLine: UIView!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var phoneText: UITextView!
    @IBOutlet weak var phoneLines: UIView!
    
    @IBOutlet weak var languageView: UIView!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var languageText: UITextView!
    @IBOutlet weak var languageLines: UIView!
    
    @IBOutlet weak var editMyCabinet: UIButton!
    @IBOutlet weak var settingSubscribe: UIButton!

    static var nameProfile = ""
    static var phoneProfile = ""
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        httpGet()
    
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        navigationItem.backBarButtonItem?.tintColor = .black
       
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        bounceScroll(scrollView: scrollView)
        
        nameView.backgroundColor = .vanillaWhite
        emailView.backgroundColor = .vanillaWhite
        phoneView.backgroundColor = .vanillaWhite
        languageView.backgroundColor = .vanillaWhite

        settingMenu()
        headerPreset()
        
        self.tabBarController?.tabBar.isHidden = true
        
        actionMenu(.init())
        hideKeyboardWhenTappedScreen()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.revealViewController()?.gestureEnabled = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController()?.gestureEnabled = true
    }
    
    @IBAction func actionMenu(_ sender: UIBarButtonItem) {
        menu.target = revealViewController()
        menu.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    @IBAction func actionSetting(_ sender: UIBarButtonItem) {
//        let vc = storyboard!.instantiateViewController(withIdentifier: "settings")
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
//        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    

    
    @IBAction func actionButtonCabinet(_ sender: UIButton) {
        
        let cancelName = nameText.text
        let cancelEmail = emailText.text
        let cancelPhone = phoneText.text
        let cancelLanguage = languageText.text
        
        nameText.text = cancelName
        emailText.text = cancelEmail
        phoneText.text = cancelPhone
        languageText.text = cancelLanguage
        
        DispatchQueue.main.async {
                self.httpEditProfile()
        }
        
        editMyCabinet.setTitle("РЕДАКТИРОВАТЬ", for: .normal)
        editMyCabinet.backgroundColor = .clear
        editMyCabinet.setTitleColor(.black, for: .normal)
        buttonSelectable = false
        settingSubscribe.isHidden = false
        settingTextView(permission: false)
        
        
//        subscriptionView.isHidden = true
        titleLabel.isHidden = false
        imageUser.isHidden = false
        nameView.isHidden = false
        name.isHidden = false
        nameText.isHidden = false
        nameLines.isHidden = false
        emailView.isHidden = false
        email.isHidden = false
        emailText.isHidden = false
        emailLine.isHidden = false
        phoneView.isHidden = false
        phone.isHidden = false
        phoneText.isHidden = false
        phoneLines.isHidden = false
        languageView.isHidden = false
        language.isHidden = false
        languageText.isHidden = false
        languageLines.isHidden = false
        editMyCabinet.isHidden = false
        settingSubscribe.isHidden = false

    }
    
   

    @IBAction func actionCard(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "SettingCard")
//        setSubView(vc!)
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func actionOffer(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "SettingOffer")
//        setSubView(vc!)
        self.tabBarController?.selectedIndex = 2
    }
    

    
    func settingMenu() {
        
        cabinetView.backgroundColor = .vanillaWhite
        imageUser.layer.cornerRadius = 55
        
        editMyCabinet.layer.cornerRadius = 5
        editMyCabinet.layer.borderWidth = 2
        editMyCabinet.layer.borderColor = UIColor.black.cgColor
        
        settingSubscribe.layer.cornerRadius = 5
        settingSubscribe.layer.borderWidth = 2
        settingSubscribe.layer.borderColor = UIColor.black.cgColor
        
        settingTextView(permission: false)
    }
    
   
    
    func settingTextView(permission: Bool) {
        nameText.isScrollEnabled = false
        emailText.isScrollEnabled = false
        phoneText.isScrollEnabled = false
        languageText.isScrollEnabled = false
        
        if permission == true {
            nameText.isEditable = true
            emailText.isEditable = true
            phoneText.isEditable = true
            languageText.isEditable = true
        } else {
            nameText.isEditable = false
            emailText.isEditable = false
            phoneText.isEditable = false
            languageText.isEditable = false
        }
    }
    
    var buttonSelectable = false
    @IBAction func actionEdit(_ sender: UIButton) {
        
        if buttonSelectable == false {
            editMyCabinet.setTitle("СОХРАНИТЬ", for: .normal)
            editMyCabinet.backgroundColor = .black
            editMyCabinet.setTitleColor(.white, for: .normal)
            settingSubscribe.isHidden = true
            buttonSelectable = true
            settingTextView(permission: true)
            imageUser.image = UIImage.init(named: "userOverlay")
        } else {
            
            DispatchQueue.main.async {
                    self.httpEditProfile()
            }
            imageUser.image = nil
            
            
            editMyCabinet.setTitle("РЕДАКТИРОВАТЬ", for: .normal)
            editMyCabinet.backgroundColor = .clear
            editMyCabinet.setTitleColor(.black, for: .normal)
            buttonSelectable = false
            settingSubscribe.isHidden = false
            settingTextView(permission: false)
        }
    }
    
    @IBAction func actionSettingSubscribe(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SubscribeView")
        setSubView(vc!)
    }
}

extension SettingProfile {
    
    //MARK: - Network
    func httpGet() {
        let url = URL(string: "https://ubusiness-ithub.ru/api/fetchProfile")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(Token.accessToken ?? "Error token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "GET"
    
        URLSession.shared.dataTask(with: request) { [self] (data, response , error) in
            
            guard let data = data else { return }
            let nsHTTPResponse = response as! HTTPURLResponse
            let statusCode = nsHTTPResponse.statusCode
            print(statusCode)
        
            do {
                let json = try JSONDecoder().decode(Profile.self, from: data)
                print(json)
                if statusCode == 200 {
                    DispatchQueue.main.async {
                        nameText.text = json.name
                        emailText.text = json.email
                        phoneText.text = json.tel
                        languageText.text = json.lang
//                        imageUser.image = json.avatarurl
                        
                        
                        imageUser.downloaded(from: "https://ubusiness-ithub.ru/avatars/\(json.avatarurl ?? "")")
                        
                       
                        
                        SettingProfile.nameProfile = nameText.text
                        SettingProfile.phoneProfile = phoneText.text
                    }
                }
            } catch {
                
                print("errpor profile")
                print(error)
            }
            
        }.resume()
    }
    
    func httpEditProfile() {
        
        let name = nameText.text ?? ""
        let email = emailText.text ?? ""
        let tel = phoneText.text ?? ""
        let lang = languageText.text ?? ""
        
    
        let url = NSURL(string: "https://ubusiness-ithub.ru/api/editProfile")!
        
        let parameters: [String: Any] = [
            "email": email,
            "name": name,
            "tel": tel,
            "lang": lang
          ]
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "PATCH"
        
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest) { [self] data, response, error in
                let nsHTTPResponse = response as? HTTPURLResponse
                let statusCode = nsHTTPResponse?.statusCode
                
                if let response = response { // change on the if response != nil ?
                    if statusCode == 200 {
                        print("Успешная смена пользовательских данных через access токен")
                    } else if statusCode == 400 {
                        print("Ответ от сервера: Выбран не подходящий формат файла при изменении фото профиля")
                    } else if statusCode == 401 {
                        print("неверный токен")
                    }
                }
                
                if let data = data {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
   
                    } catch _ {
                        print("Неправильный ответ в формате JSON")
                    }
                }
                
                if let error = error {
                    print ("\(error)")
                }
            }
            task.resume()
        }
    }
}

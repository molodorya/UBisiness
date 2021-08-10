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
        headerTextCabinet.text = "мой\nкабинет"
        headerButtonCabinet.backgroundColor = .clear
        
        // Card
        headerTextCard.adjustsFontSizeToFitWidth = true
        headerTextCard.text = "моя\nвизитка"
        headerButtonCard.backgroundColor = .clear
        
        //Offer
        headerTextCabinet.adjustsFontSizeToFitWidth = true
        headerTextOffer.text = "мои спец.\nпредложения"
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
    
    
    
    //MARK: - subscription view's
    @IBOutlet weak var subscriptionView: UIView!
    @IBOutlet weak var subscriptionHeader: UIView!
    
    @IBOutlet weak var subscriptionTitle: UILabel!
    @IBOutlet weak var subscriptionEnd: UILabel!
    @IBOutlet weak var subscriptionPrice: UILabel!
    
    
    @IBOutlet weak var firstTitle: UILabel!
    @IBOutlet weak var lastTitle: UILabel!
    
    @IBOutlet weak var firstPrice: UILabel!
    @IBOutlet weak var lastPrice: UILabel!
    
    @IBOutlet weak var firstDate: UILabel!
    @IBOutlet weak var lastDate: UILabel!
    
    @IBOutlet weak var extend: UIButton!
    @IBOutlet weak var change: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        settingSubscriptionView()
        headerPreset()
        
     
        actionMenu(.init())
        hideKeyboardWhenTappedScreen()
    
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.revealViewController()?.gestureEnabled = false
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        
        // Может быть мелькает при переходах потому-что в viewDidAppear это засунул?
        UserDefaults.standard.setValue(NetworkSettingProfile.userNetwork, forKey: "userNetwok")
        UserDefaults.standard.setValue(NetworkSettingProfile.emailNetwork, forKey: "emailNetwork")
        UserDefaults.standard.setValue(NetworkSettingProfile.phoneNetwork, forKey: "phoneNetwork")
        UserDefaults.standard.setValue(NetworkSettingProfile.languageNetwork, forKey: "languageNetwork")
        

        nameText.text = UserDefaults.standard.string(forKey: "userNetwok")
        emailText.text = UserDefaults.standard.string(forKey: "emailNetwork")
        phoneText.text = UserDefaults.standard.string(forKey: "phoneNetwork")
        languageText.text = UserDefaults.standard.string(forKey: "languageNetwork")
        
        

   

     
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
//        let vc = storyboard!.instantiateViewController(withIdentifier: "settings") as! Settings
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
                self.httpGet()
        }
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
        
        
        subscriptionView.isHidden = true
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
        let vc = storyboard?.instantiateViewController(identifier: "SettingCard")
        setSubView(vc!)
        
        print("ff")
        
    }
    
    @IBAction func actionOffer(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingOffer")
        setSubView(vc!)
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
        } else {
            
            DispatchQueue.main.async {
                    self.httpEditProfile()
            }
            
            editMyCabinet.setTitle("РЕДАКТИРОВАТЬ", for: .normal)
            editMyCabinet.backgroundColor = .clear
            editMyCabinet.setTitleColor(.black, for: .normal)
            buttonSelectable = false
            settingSubscribe.isHidden = false
            settingTextView(permission: false)
        }
    }
    
    @IBAction func actionSettingSubscribe(_ sender: UIButton) {
        subscriptionView.isHidden = false
        
        cabinetView.isHidden = false
        titleLabel.isHidden = true
        imageUser.isHidden = true
        nameView.isHidden = true
        name.isHidden = true
        nameText.isHidden = true
        nameLines.isHidden = true
        emailView.isHidden = true
        email.isHidden = true
        emailText.isHidden = true
        emailLine.isHidden = true
        phoneView.isHidden = true
        phone.isHidden = true
        phoneText.isHidden = true
        phoneLines.isHidden = true
        languageView.isHidden = true
        language.isHidden = true
        languageText.isHidden = true
        languageLines.isHidden = true
        editMyCabinet.isHidden = true
        settingSubscribe.isHidden = true
        
        print("setting Subscribe")
    }
    
    
    
    
    
    
    
   
    //MARK: - Подписка
    @IBAction func actionExtend(_ sender: UIButton) {
        print("actionExtend")
    }
    
    @IBAction func actionChange(_ sender: UIButton) {
        print("actionChange")
    }
    
    @IBAction func actionCancel(_ sender: UIButton) {
        print("actionCancel")
    }
    
}

//MARK: -  подписка
extension SettingProfile {
    func settingSubscriptionView() {
        subscriptionView.backgroundColor = .vanillaWhite
        subscriptionHeader.backgroundColor = .vanillaWhiteContrast

        extend.layer.cornerRadius = 5
        change.backgroundColor = .clear
        change.layer.borderWidth = 2
        change.layer.borderColor = UIColor.black.cgColor
        change.layer.cornerRadius = 5
        subscriptionView.isHidden = true
    }
}




enum NetworkSettingProfile {
    static var userNetwork = ""
    static var emailNetwork = ""
    static var phoneNetwork = ""
    static var languageNetwork = ""
    static var idUser = 1
}


extension SettingProfile {
    
    //MARK: - Network
    func httpGet() {
        let url = URL(string: "https://ubusiness-ithub.ru/api/fetchProfile")!
        var request = URLRequest(url: url)
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Nywicm9sZSI6InVzZXIiLCJpYXQiOjE2MjgzNzMzMDksImV4cCI6MTYzMDk2NTMwOX0.CMt0-9cWpNGA9lWzTya4GUe3H6mDc8KphQZSd-xBkjg", forHTTPHeaderField: "Authorization")
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
                    NetworkSettingProfile.userNetwork = json.name ?? "—"
                    NetworkSettingProfile.emailNetwork = json.email ?? "—"
                    NetworkSettingProfile.phoneNetwork = json.tel ?? "—"
                    NetworkSettingProfile.languageNetwork = json.lang ?? "—"
                    NetworkSettingProfile.idUser = json.idUser ?? 0
                    print("Добавить для аватара")
                    
                    DispatchQueue.main.async {
                        nameText.text = NetworkSettingProfile.userNetwork
                        emailText.text = NetworkSettingProfile.emailNetwork
                        phoneText.text = NetworkSettingProfile.phoneNetwork
                        languageText.text = NetworkSettingProfile.languageNetwork
                    }
                }
            } catch {
                print("errpor profile")
                print(error
                )
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
            "lang": lang,
            "idUser": 7
          ]
        
       
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "POST"
        
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest) { data, response, error in
                let nsHTTPResponse = response as! HTTPURLResponse
                let statusCode = nsHTTPResponse.statusCode
                
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
                        print ("data: \(jsonResponse)")
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

//
//  SettingCard.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 30.07.2021.
//

import UIKit

class SettingCard: UIViewController {
    
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
    
    // View
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var cardNotLabel: UILabel!
    @IBOutlet weak var cardNotButton: UIButton!
    
    
    
    @IBOutlet weak var change: UIButton!
    
    @IBOutlet weak var viewButtonsTop: UIView!
    @IBOutlet weak var details: UIButton!
    @IBOutlet weak var imageDetails: UIImageView!
    
    @IBOutlet weak var viewButtonsBottom: UIView!
    @IBOutlet weak var turn: UIButton!
    @IBOutlet weak var imageTurn: UIImageView!
    
    @IBOutlet weak var headerUserView: UIView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userGroup: UILabel!
    @IBOutlet weak var statusTel: UIImageView!
    @IBOutlet weak var statusTelText: UILabel!
    
    
    
    @IBOutlet weak var industryView: UIView!
    @IBOutlet weak var industryTitle: UILabel!
    @IBOutlet weak var industryText: UITextView!
    @IBOutlet weak var industryLines: UIView!
    
    @IBOutlet weak var nameCompanyView: UIView!
    @IBOutlet weak var nameCompanyTitle: UILabel!
    @IBOutlet weak var nameCompanyText: UITextView!
    @IBOutlet weak var nameCompanyLines: UIView!
    
    @IBOutlet weak var imageCompanyView: UIView!
    @IBOutlet weak var imageCompany: UIImageView!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var phoneTitle: UILabel!
    @IBOutlet weak var phoneText: UITextView!
    @IBOutlet weak var phoneLines: UIView!
    
    @IBOutlet weak var contryView: UIView!
    @IBOutlet weak var countryTitle: UILabel!
    @IBOutlet weak var countryText: UITextView!
    @IBOutlet weak var countryLines: UIView!
    
    @IBOutlet weak var streetView: UIView!
    @IBOutlet weak var streetTitle: UILabel!
    @IBOutlet weak var streetText: UITextView!
    @IBOutlet weak var streetLines: UIView!
    
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tagTitle: UILabel!
    @IBOutlet weak var tagText: UITextView!
    @IBOutlet weak var tagLines: UIView!
    
    
    // Constraint
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cardViewHeight: NSLayoutConstraint!

    
    
    
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
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchBusinessCard()
        
        cardNotLabel.isHidden = true
        cardNotButton.isHidden = true
        
        nameUser.textAlignment = .left
        nameUser.adjustsFontSizeToFitWidth = true

        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        cardView.backgroundColor = .vanillaWhiteContrast
        
        cardView.layer.cornerRadius = 5
        cardView.clipsToBounds = true
        
        
        userImage.layer.cornerRadius = 50
        
        change.layer.cornerRadius = 5
        change.layer.borderWidth = 2
        change.layer.borderColor = UIColor.black.cgColor
        
        headerUserView.backgroundColor = .vanillaWhiteContrast
        userView.backgroundColor = .vanillaWhiteContrast
        viewButtonsTop.backgroundColor = .vanillaWhiteContrast
        viewButtonsBottom.backgroundColor = .vanillaWhiteContrast
        industryView.backgroundColor = .vanillaWhiteContrast
        nameCompanyView.backgroundColor = .vanillaWhiteContrast
        phoneView.backgroundColor = .vanillaWhiteContrast
        imageCompanyView.backgroundColor = .vanillaWhiteContrast
        contryView.backgroundColor = .vanillaWhiteContrast
        streetView.backgroundColor = .vanillaWhiteContrast
        tagView.backgroundColor = .vanillaWhiteContrast
        
        
        industryText.backgroundColor = .vanillaWhiteContrast
        nameCompanyText.backgroundColor = .vanillaWhiteContrast
        phoneText.backgroundColor = .vanillaWhiteContrast
        countryText.backgroundColor = .vanillaWhiteContrast
        streetText.backgroundColor = .vanillaWhiteContrast
        tagText.backgroundColor = .vanillaWhiteContrast

        headerPreset()
        startPreset()
 
    }

    
    
    func startPreset() {
        

        cardViewHeight.constant = 420
        scrollViewHeight.constant = 800
        
        details.isHidden = false
        imageDetails.isHidden = false
        
//        statusTel.isHidden = true
//        statusTelText.isHidden = true
        
        turn.isHidden = true
        imageTurn.isHidden = true
        
        industryTitle.isHidden = false
        industryText.isHidden = false
        industryLines.isHidden = false
        
        nameCompanyTitle.isHidden = false
        nameCompanyText.isHidden = false
        nameCompanyLines.isHidden = false
        
        imageCompany.isHidden = true
        
        phoneTitle.isHidden = true
        phoneText.isHidden = true
        phoneLines.isHidden = true
        
        countryTitle.isHidden = true
        countryText.isHidden = true
        countryLines.isHidden = true
        
        streetTitle.isHidden = true
        streetText.isHidden = true
        streetLines.isHidden = true
        
        tagTitle.isHidden = true
        tagText.isHidden = true
        tagLines.isHidden = true
        
        settingTextView(permission: false)
    }
    
    func offPreset() {
        
        details.isHidden = true
        imageDetails.isHidden = true
        
        turn.isHidden = false
        imageTurn.isHidden = false
        
        imageCompany.isHidden = false
        
        phoneTitle.isHidden = false
        phoneText.isHidden = false
        phoneLines.isHidden = false
        
        countryTitle.isHidden = false
        countryText.isHidden = false
        countryLines.isHidden = false
        
        streetTitle.isHidden = false
        streetText.isHidden = false
        streetLines.isHidden = false
        
        tagTitle.isHidden = false
        tagText.isHidden = false
        tagLines.isHidden = false
    }
    
    func settingTextView(permission: Bool) {
        
        industryText.isScrollEnabled = false
        nameCompanyText.isScrollEnabled = false
        phoneText.isScrollEnabled = false
        countryText.isScrollEnabled = false
        streetText.isScrollEnabled = false
        tagText.isScrollEnabled = false
        
        if permission == true {
            industryText.isEditable = true
            nameCompanyText.isEditable = true
            phoneText.isEditable = true
            countryText.isEditable = true
            streetText.isEditable = true
            tagText.isEditable = true
        } else {
            industryText.isEditable = false
            nameCompanyText.isEditable = false
            phoneText.isEditable = false
            countryText.isEditable = false
            streetText.isEditable = false
            tagText.isEditable = false
        }
    }
    
    
    
    @IBAction func actionCabinet(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "SettingProfile")
//        setSubView(vc!)
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func actionOffer(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "SettingOffer")
//        setSubView(vc!)
        self.tabBarController?.selectedIndex = 2
    }
    
    


    
    
    @IBAction func buttonDetails(_ sender: UIButton) {
       
        UIView.animate(withDuration: 0.3) {
            self.cardViewHeight.constant = 1015
            self.scrollViewHeight.constant = 1300
        }
        offPreset()
    }
    
    @IBAction func buttonTurn(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
            self.cardViewHeight.constant = 420
            self.scrollViewHeight.constant = 800
        }
        startPreset()
    }
    
    
    
    
    var buttonSelectable = false
    @IBAction func buttonChange(_ sender: UIButton) {
        cardView.isHidden = false
        if buttonSelectable == false {
            offPreset()
            change.setTitle("СОХРАНИТЬ", for: .normal)
            change.backgroundColor = .black
            change.setTitleColor(.white, for: .normal)
            self.cardViewHeight.constant = 1015
            self.scrollViewHeight.constant = 1300
            buttonSelectable = true
            settingTextView(permission: true)
          print("a")
        } else {
            changeCard(url: "https://ubusiness-ithub.ru/api/editBusinessCard")
            change.setTitle("ИЗМЕНИТЬ", for: .normal)
            change.backgroundColor = .clear
            change.layer.borderWidth = 2
            change.layer.borderColor = UIColor.black.cgColor
            change.setTitleColor(.black, for: .normal)
            buttonSelectable = false
        
            
            
            settingTextView(permission: false)
        }
        
    }
    
    
    @IBAction func createCards(_ sender: UIButton) {
        cardNotLabel.isHidden = true
        cardNotButton.isHidden = true
        
        userImage.isHidden = false
        nameUser.isHidden = false
        userView.isHidden = false
        industryView.isHidden = false
        nameCompanyView.isHidden = false
        viewButtonsBottom.isHidden = false
        change.isHidden = false
        buttonChange(.init())
    }
    
    
}




extension SettingCard {
    
    struct FetchBusinessCardElement: Decodable {
        var id_card: Int?
        var user: String?
        var status: Bool?
        var avatarurl: String?
        var company: String?
        var urllogo: String?
        var tel: String?
        var industry: String?
        var country: String?
        var address: String?
        var tags: String?
    }
    
    func fetchBusinessCard() {
        var request = URLRequest.init(url: NSURL(string: "https://ubusiness-ithub.ru/api/fetchBusinessCard")! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        print("подгрузка заранее")

        let dataTask = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            
            let nsHTTPResponse = response as? HTTPURLResponse
            let statusCode = nsHTTPResponse?.statusCode ?? 0
            print(statusCode)
            
            if let data = data {
                
                do {
     
                    let json = try JSONDecoder().decode([FetchBusinessCardElement].self, from: data)
                    
                    let jsonData = json[0]
                    print(jsonData)

                    
                    if statusCode == 200 {
                        
                        DispatchQueue.main.async {
                            print("fwergiwergnie")
                            
                            
                            if jsonData.industry == nil && jsonData.company == nil && jsonData.address == nil {
                                
                                cardNotLabel.isHidden = false
                                cardNotButton.isHidden = false
                                
                                userImage.isHidden = true
                                nameUser.isHidden = true
                                userView.isHidden = true
                                industryView.isHidden = true
                                nameCompanyView.isHidden = true
                                viewButtonsBottom.isHidden = true
                                change.isHidden = true
                                
                                cardNotButton.layer.cornerRadius = 5
                                
                                
//                                change.setTitle("СОЗДАТЬ ВИЗИТКУ", for: .normal)
        
                                print("nil")
                            } else {
                                nameUser.text = jsonData.user
                                industryText.text = jsonData.industry
                                nameCompanyText.text = jsonData.company
                                phoneText.text = jsonData.tel
                                countryText.text = jsonData.country
                                streetText.text = jsonData.address
                                tagText.text = jsonData.tags
                            }
                            
                           
                            
                            
                            if jsonData.status == true {
                                statusTel.image = UIImage.init(systemName: "checkmark")?.withTintColor(.green)

                                statusTel.isHidden = false
                                statusTelText.isHidden = false
                            } else {
                                statusTel.isHidden = true
                                statusTelText.isHidden = true
                            }
                        }
                    } else if statusCode != 200 {
                        print(statusCode)
                    }
                    
                } catch _ {
                    print ("Неправильный ответ в формате JSON")
                }
            }
        })
        dataTask.resume()
    }
    
    
    
    
    struct SuccesChange: Decodable {
        let ru: String?
        let en: String?
        let de: String?
    }
    
    func changeCard(url: String) {
        let url = NSURL(string: url)!
        
        let industry = industryText.text ?? ""
        let company = nameCompanyText.text ?? ""
        let phone = phoneText.text ?? ""
        let country = countryText.text ?? ""
        let street = streetText.text ?? ""
        let tags = tagText.text ?? ""
        
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "PATCH"
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("Accept", forHTTPHeaderField: "application/json")
        request.addValue("Content-Type", forHTTPHeaderField: "application/json")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters :[String: Any]? = ["name": company,
                                          "country": country,
                                          "address": street,
                                          "industry": industry,
                                          "tags": tags,
                                          "tel": phone]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                let nsHTTPResponse = response as? HTTPURLResponse
                let statusCode = nsHTTPResponse?.statusCode
                if response != nil {
                    print ("status code = \(statusCode ?? 0)")
                }
                if let error = error {
                    print (" \(error)")
                }
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(SuccesChange.self, from: data)
                        print(json)
                        DispatchQueue.main.async { [self] in
                            if statusCode == 200 {
                                UserDefaults.standard.setValue(industry, forKey: "cardIndustry")
                                UserDefaults.standard.setValue(company, forKey: "cardNameCompany")
                                UserDefaults.standard.setValue(country, forKey: "cardCountry")
                                UserDefaults.standard.setValue(street, forKey: "cardCompanyAddress")
                                UserDefaults.standard.setValue(tags, forKey: "cardTags")
                            } else if statusCode == 401 {
                                
                                DispatchQueue.main.async {
                                    let alert = UIAlertController(title: "Пользователь не найден", message: "E-Mail или пароль введены не корректно", preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                    vibrationFunc(tapping: .heavy)
                                }
                            }
                        }
                    } catch _ {
                        print ("Неправильный ответ в формате JSON")
                    }
                }
            })
            task.resume()
        } catch _ {
            print ("Незадокументированная ошибка")
        }
    }
    
}


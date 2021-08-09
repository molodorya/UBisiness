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
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
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
        
        addText()
        headerPreset()
        startPreset()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.cardView.frame.size.height = 411

        fetchBusinessCard()
    }
    
    func addText() {
        industryText.text = "Энергетика"
        nameCompanyText.text = "Газпром"
        phoneText.text = "+ 7 (926) 753-66-95"
        countryText.text = "Россия"
        streetText.text = "Малая ордынка. д 20"
        tagText.text = "#gazprom, #usdrub, #music, #cosmetics"
        
        
    }
    
    
    
    func startPreset() {
        
        self.topConstraint.constant = 50
        self.bottomConstraint.constant = 643
        
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
        
        self.topConstraint.constant = 50
        self.bottomConstraint.constant = 50
        
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
        let vc = storyboard?.instantiateViewController(identifier: "SettingProfile")
        setSubView(vc!)
    }
    
    @IBAction func actionOffer(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingOffer")
        setSubView(vc!)
    }
    
    
    // default 50
    // change 643
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    // default 50
    // change 643
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func buttonDetails(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
//            self.topConstraint.constant = 50
//            self.bottomConstraint.constant = 50
        }
        offPreset()
    }
    
    @IBAction func buttonTurn(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
//            self.topConstraint.constant = 50
//            self.bottomConstraint.constant = 643
        }
        startPreset()
    }
    
    
    
    
    var buttonSelectable = false
    @IBAction func buttonChange(_ sender: UIButton) {
        
        if buttonSelectable == false {
            offPreset()
            
            
            change.setTitle("СОХРАНИТЬ", for: .normal)
            change.backgroundColor = .black
            change.setTitleColor(.white, for: .normal)
//            change.isHidden = true
            buttonSelectable = true
            settingTextView(permission: true)
            DispatchQueue.main.async {
                    print("изменить данные (отправка на сервер)")
            }
        } else {
            
            change.setTitle("ИЗМЕНИТЬ", for: .normal)
            change.backgroundColor = .clear
            change.layer.borderWidth = 2
            change.layer.borderColor = UIColor.black.cgColor
            change.setTitleColor(.black, for: .normal)
            buttonSelectable = false
//            change.isHidden = clea
            settingTextView(permission: false)
        }
        
    }
    
}




extension SettingCard {
    
    
    
    
    struct FetchBusinessCardElement: Decodable {
        var name: String?
        var status: Bool?
        var avatarurl, company, urllogo, country: String?
        var address, tags: String?
    }
    
    
    enum NetworkSettingCard {
        static var name = ""
        static var industry = ""
        static var avatar = ""
        static var company = ""
        static var logo = ""
        static var country = ""
        static var address = ""
        static var tags = ""
        static var status = false
    }
    
    func fetchBusinessCard() {
        var request = URLRequest.init(url: NSURL(string: "https://ubusiness-ithub.ru/api/fetchBusinessCard")! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        

        let dataTask = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            
            let nsHTTPResponse = response as? HTTPURLResponse
            let statusCode = nsHTTPResponse?.statusCode ?? 0
            print(statusCode)
            
            if let data = data {
                
                do {
     
                    let json = try JSONDecoder().decode([FetchBusinessCardElement].self, from: data)
                    
                    if statusCode == 200 {
                        
                        NetworkSettingCard.name = json[0].name ?? "—"
                        NetworkSettingCard.avatar = json[0].avatarurl ?? "—"
                        NetworkSettingCard.company = json[0].company ?? "—"
                        NetworkSettingCard.logo = json[0].urllogo ?? "—"
                        NetworkSettingCard.country = json[0].country ?? "—"
                        NetworkSettingCard.address = json[0].address ?? "—"
                        NetworkSettingCard.tags = json[0].tags ?? "—"
                        NetworkSettingCard.status = json[0].status ?? false
                        
                        DispatchQueue.main.async { [self] in
                            nameUser.text = NetworkSettingCard.name
                            phoneText.text = NetworkSettingProfile.phoneNetwork
                            nameUser.text = NetworkSettingProfile.userNetwork
                            nameCompanyText.text = NetworkSettingCard.company
                            phoneText.text = NetworkSettingProfile.phoneNetwork
                            countryText.text = NetworkSettingCard.country
                            streetText.text = NetworkSettingCard.address
                            tagText.text = NetworkSettingCard.tags
                            
                            if NetworkSettingCard.status == true {
                                statusTel.image = UIImage.init(systemName: "checkmark")?.withTintColor(.green)
                                
                                statusTel.isHidden = false
                                statusTelText.isHidden = false
                            } else {
//                                statusTel.isHidden = true
//                                statusTelText.isHidden = true
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
}

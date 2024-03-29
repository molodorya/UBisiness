//
//  CardFull.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 13.08.2021.
//

import UIKit

class CardFull: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    
    // View
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var add: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserId()
        
//        viewButtonsTop.isHidden = true
//        viewButtonsBottom.isHidden = false
        
        
        if CardSearch.add_delete == false {
            add.setTitle("ДОБАВИТЬ В КОНТАКТЫ", for: .normal)
        } else {
            add.setTitle("УДАЛИТЬ ИЗ КОНТАКТОВ", for: .normal)
        }

        turn.underLineButton(text: "свернуть")
        details.underLineButton(text: "подробнее")
        
        nameUser.text = ""
        nameCompanyText.text = ""
        industryText.text = ""
        phoneText.text = ""
        countryText.text = ""
        streetText.text = ""
        tagText.text = ""
        
        settingTextView(permission: false)
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        cardView.layer.cornerRadius = 5
        cardView.clipsToBounds = true
        userImage.layer.cornerRadius = 50
        
        add.layer.cornerRadius = 5
       
        
        cardView.backgroundColor = .vanillaWhiteContrast
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
        
        details.isHidden = true
        imageDetails.isHidden = true
        
//        statusTel.isHidden = true
//        statusTelText.isHidden = true
    
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
    
    @IBOutlet weak var cardViewHeight: NSLayoutConstraint!
    
    @IBAction func detailsAction(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3) {
        self.cardViewHeight.constant = 1015
//        self.scrollViewHeight.constant = 1300
        }
        
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
    
    @IBAction func turnAction(_ sender: UIButton) {
        cardViewHeight.constant = 420
//        scrollViewHeight.constant = 800
        
        scrollView.scrollToBottom(animated: true)
        
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
        
    }
    
    
    
    @IBAction func addFavorite(_ sender: UIButton) {

        if CardSearch.add_delete == false {
            add.setTitle("ДОБАВИТЬ В КОНТАКТЫ", for: .normal)
            addFavorite(url: "https://ubusiness-ithub.ru/api/addFavoriteCard")
            
            
            
        } else {
            add.setTitle("УДАЛИТЬ ИЗ КОНТАКТОВ", for: .normal)
            deleteFavorit(url: "https://ubusiness-ithub.ru/api/deleteFavoriteCard")
        }
    }
}

struct CardContact: Codable {
    var idCard: Int?
    var user, avatarurl: String?
    var status: Bool?
    var company, industry: String?
    var country: String?
    var address: String?
    var tags: String?
    var urllogo: String?

    enum CodingKeys: String, CodingKey {
        case idCard = "id_card"
        case user, avatarurl, status, company, industry, country, address, tags
    }
}


extension CardFull {
    func fetchUserId() {
        
        let idCardTouch = UserDefaults.standard.integer(forKey: "idCardClick")
        
        var request = URLRequest.init(url: NSURL(string: "https://ubusiness-ithub.ru/api/businessCard?id=\(idCardTouch)")! as URL)
        
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(CardContact.self, from: data)
                  
                    DispatchQueue.main.async { [self] in
                        nameUser.text = json.user
                        
                        if json.status == true {
                            print("тру")
                        } else {
                            print("фалсе")
                        }
                        
                        
                        industryText.text = json.industry
                        nameCompanyText.text = json.company
                        countryText.text = json.country
                        streetText.text = json.address
                        tagText.text = json.tags
                    
                        userImage.downloaded(from: "https://ubusiness-ithub.ru/avatars/\(json.avatarurl ?? "")")
                        
                        imageCompany.downloaded(from: "https://ubusiness-ithub.ru/companies/\(json.urllogo ?? "")")
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}

struct RequestAddFavorite: Codable {
    var ru: String?
    var en: String?
    var de: String?
}

struct RequestDeleteFavorite: Codable {
    var ru: String?
    var en: String?
    var de: String?
}

extension CardFull {
    
    
    func addFavorite(url: String) {
        let url = NSURL(string: url)!
        
        let parameters: [String: Any] = [
            "iduser": Token.idUser, 
            "id_card": UserDefaults.standard.integer(forKey: "idCardClick")]
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            let nsHTTPResponse = response as! HTTPURLResponse
            let statusCode = nsHTTPResponse.statusCode
            if let data = data {
                print(statusCode)
                do {
                    let json = try JSONDecoder().decode(RequestAddFavorite.self, from: data)
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self.add.setTitle("В ИЗБРАННЫХ", for: .normal)
                        let alertController = UIAlertController(title: json.ru ?? "", message: "Возможны ошибки", preferredStyle:UIAlertController.Style.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                        self.present(alertController, animated: true, completion: nil)
                        
                       
                    }
                    
                    
                    print(json)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    
    func deleteFavorit(url: String) {
        let url = NSURL(string: url)!
        
        let parameters: [String: Any] = [
            "iduser": Token.idUser,
            "id_card": UserDefaults.standard.integer(forKey: "idCardClick")]
        
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            let nsHTTPResponse = response as! HTTPURLResponse
            let statusCode = nsHTTPResponse.statusCode
            if let data = data {
                print(statusCode)
                do {
                    let json = try JSONDecoder().decode(RequestDeleteFavorite.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                        let alertController = UIAlertController(title: json.ru ?? "", message: nil, preferredStyle:UIAlertController.Style.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
//                        self.present(alertController, animated: true, completion: {
                           
                            
//                        })
                    }
                    print(json)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}



extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: -100)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}

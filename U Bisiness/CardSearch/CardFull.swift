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
        
        viewButtonsTop.isHidden = true
        viewButtonsBottom.isHidden = false
        
        
        turn.underLineButton(text: "свернуть")
        
        nameUser.text = "-"
        
        nameCompanyText.text = "-"
        industryText.text = "-"
        phoneText.text = "-"
        countryText.text = "-"
        streetText.text = "-"
        tagText.text = "-"
        
        fetchUserId()
        
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
                        nameCompanyText.text = json.company
                        countryText.text = json.country
                        streetText.text = json.address
                        tagText.text = json.tags
                        
//                        avatar
                        
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}

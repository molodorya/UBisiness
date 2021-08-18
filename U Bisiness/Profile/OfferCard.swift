//
//  OfferCard.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.08.2021.
//

import UIKit

class OfferCard: UIViewController {
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
    
    @IBOutlet weak var buttonImage: UIButton!
    
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var viewProtocol: UIView!
    @IBOutlet weak var viewDate: UIView!
    @IBOutlet weak var viewText: UIView!
    
    @IBOutlet weak var nameText: UITextView!
    @IBOutlet weak var protocolText: UITextView!
    @IBOutlet weak var dateText: UITextView!
    @IBOutlet weak var textText: UITextView!
    
    @IBOutlet weak var top: UIButton!
    @IBOutlet weak var save: UIButton!
    
    static var idCard = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchIdCard()
        buttonImage.layer.cornerRadius = 5
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
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
        
        
        viewName.backgroundColor = .vanillaWhite
        viewProtocol.backgroundColor = .vanillaWhite
        viewDate.backgroundColor = .vanillaWhite
        viewText.backgroundColor = .vanillaWhite
        
        nameText.backgroundColor = .vanillaWhite
        protocolText.backgroundColor = .vanillaWhite
        dateText.backgroundColor = .vanillaWhite
        textText.backgroundColor = .vanillaWhite
        
        nameText.isScrollEnabled = false
        protocolText.isScrollEnabled = false
        dateText.isScrollEnabled = false
        textText.isScrollEnabled = false
        
        top.layer.cornerRadius = 5
        save.layer.cornerRadius = 5
        
        top.layer.borderWidth = 2
        top.layer.borderColor = UIColor.black.cgColor
        
        hideKeyboardWhenTappedScreen()
    }
    
    
    @IBAction func topAction(_ sender: UIButton) {
        topOffer(url: "https://ubusiness-ithub.ru/api/updateTime")
    }
    
    @IBAction func topSave(_ sender: UIButton) {
        editOffer(url: "https://ubusiness-ithub.ru/api/editOffers")
    }
    
    struct FetchIdCard: Codable {
        var id: Int?
        var imgurl: String?
        var title: String?
        var `protocol`: String?
        var timecreation: String?
        var term: String?
        var text: String?
        var idcreator: Int?
        var type: String?
    }
    
    struct RequestMessage: Codable {
        var idOffer: Int?
        var ru: String?
        var en: String?
        var de: String?
    }

    func fetchIdCard() {
        let id = UserDefaults.standard.string(forKey: "selectCardId")
        var request = URLRequest.init(url: NSURL(string: "https://ubusiness-ithub.ru/api/fetchOffer?id=\(id ?? "")")! as URL)
        print(id)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        print("подгрузка заранее")

        let dataTask = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            if let data = data {
                
                do {
                    let json = try JSONDecoder().decode(FetchIdCard.self, from: data)
                    
                    DispatchQueue.main.async {
                        nameText.text = json.title
                        protocolText.text = json.protocol
                        dateText.text = json.term
                        textText.text = json.text
                        OfferCard.idCard = json.id ?? 0
                        print(json)
                    }
                   
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        dataTask.resume()
    }
    
    
    
    func editOffer(url: String) {
       
            let id = UserDefaults.standard.string(forKey: "selectCardId")
            let url = NSURL(string: url)!
            
            let parameters: [String: Any] = [
                "title": nameText.text ?? "",
                "protocol": protocolText.text ?? "",
                "text": textText.text ?? "",
                "idOffer": id ?? 0,
                "type": "offer"]
     
            
            let session = URLSession.shared
            let request = NSMutableURLRequest(url: url as URL)
            
            request.httpMethod = "PATCH"
            
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
                        let json = try JSONDecoder().decode(RequestMessage.self, from: data)
                        
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: json.ru, message: nil, preferredStyle:UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
    }
    
    
    func topOffer(url: String) {
        if OfferCard.idCard != 0 {
            let url = NSURL(string: url)!
            
            let parameters: [String: Any] = [
                "idOffer": CreateOffer.newIdOffer]
            
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
                        let json = try JSONDecoder().decode(RequestMessage.self, from: data)
                       
                        DispatchQueue.main.async {
                            let alertController = UIAlertController(title: json.ru, message: nil, preferredStyle:UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                            self.present(alertController, animated: true, completion: nil)
                            
                        }
                        
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
            
        } else {
            let alertController = UIAlertController(title: "Создайте предложение", message: nil, preferredStyle:UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}




//
//  CreateOffer.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 15.08.2021.
//

import UIKit


struct SuccesAdd: Decodable {
    let ru: String?
    let en: String?
    let de: String?
}

class CreateOffer: UIViewController {
    
    @IBOutlet weak var nameText: UITextView!
    @IBOutlet weak var protocolName: UITextView!
    @IBOutlet weak var termDate: UITextView!
    @IBOutlet weak var promptText: UITextView!
    
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
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var protocolView: UIView!
    @IBOutlet weak var termView: UIView!
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var button: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        nameView.backgroundColor = .vanillaWhite
        protocolView.backgroundColor = .vanillaWhite
        termView.backgroundColor = .vanillaWhite
        textView.backgroundColor = .vanillaWhite
        
        nameText.backgroundColor = .vanillaWhite
        protocolName.backgroundColor = .vanillaWhite
        promptText.backgroundColor = .vanillaWhite
        termDate.backgroundColor = .vanillaWhite
        promptText.backgroundColor = .vanillaWhite
        
        button.layer.cornerRadius = 5
        
        let alertController = UIAlertController(title: "В разработке", message: "Возможны ошибки", preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addCard(_ sender: UIButton) {
        addCardNetwork(url: "https://ubusiness-ithub.ru/api/createOffer")
    }
}

extension CreateOffer {
    func addCardNetwork(url: String) {
        
        let url = NSURL(string: url)!
        
        let parameters: [String: Any] = [
            "title": nameText.text ?? "",
            "protocol": protocolName.text ?? "",
            "term": termDate.text ?? "",
            "text": promptText.text ?? "",
            "idcreator": Token.idUser
        ]
        
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
                    let json = try JSONDecoder().decode(SuccesAdd.self, from: data)
                    print(json)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

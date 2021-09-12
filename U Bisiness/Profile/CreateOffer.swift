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

class CreateOffer: UIViewController, UIImagePickerControllerDelegate,  UINavigationControllerDelegate {
    
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
    @IBOutlet weak var imageViewButton: UIImageView!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var protocolView: UIView!
    @IBOutlet weak var termView: UIView!
    @IBOutlet weak var textView: UIView!
    
    @IBOutlet weak var nameText: UITextView!
    @IBOutlet weak var protocolName: UITextView!
    @IBOutlet weak var termDate: UITextView!
    @IBOutlet weak var promptText: UITextView!
    
    @IBOutlet weak var top: UIView!
    @IBOutlet weak var add: UIButton!
    
    static var newIdOffer = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonImage.layer.cornerRadius = 5

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
  
        nameText.isScrollEnabled = false
        protocolName.isScrollEnabled = false
        promptText.isScrollEnabled = false
        termDate.isScrollEnabled = false
        promptText.isScrollEnabled = true
        
        
        top.layer.borderWidth = 2
        top.layer.borderColor = UIColor.black.cgColor
        top.layer.cornerRadius = 5
        add.layer.cornerRadius = 5
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        hideKeyboardWhenTappedScreen()
//        imagePicker.delegate = self
        imageView.layer.cornerRadius = 5
        
        
    }
    
    
    // Open gallery
    @IBOutlet var imageView: UIImageView!
    var imagePicker = UIImagePickerController()

    @IBAction func setPicture(_ sender: Any) {
         if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
             imagePicker.delegate = self
             imagePicker.sourceType = .photoLibrary
             imagePicker.allowsEditing = false

             present(imagePicker, animated: true, completion: nil)
         }
     }

     func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         picker.dismiss(animated: true, completion: nil)
         if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
             imageView.image = image
         }

     }


    
    
    // Keyboard top
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    // Keyboard hide
  @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
        self.removeFromParent()
        self.view.removeFromSuperview()
       }
    
    // Navigator menu
    @IBAction func actionCabinet(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "SettingProfile")
//        setSubView(vc!)
        self.tabBarController?.selectedIndex = 0
    }
    
    @IBAction func actionCard(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "SettingCard")
//        setSubView(vc!)
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func actionOffer(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(identifier: "SettingOffer")
//        setSubView(vc!)
//        self.tabBarController?.selectedIndex = 2
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    
    
    @IBAction func addTop(_ sender: UIButton) {
        topOffer(url: "https://ubusiness-ithub.ru/api/updateTime")
    }
    
    @IBAction func addCard(_ sender: UIButton) {
        addCardNetwork(url: "https://ubusiness-ithub.ru/api/createOffer")
    }
    
    
    
    
    struct RequestMessage: Codable {
        var idOffer: Int?
        var ru: String?
        var en: String?
        var de: String?
    }
    
    
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
                    let json = try JSONDecoder().decode(RequestMessage.self, from: data)
                   
                    DispatchQueue.main.async {
                        CreateOffer.newIdOffer = json.idOffer ?? 0
                        let alertController = UIAlertController(title: "Успешно", message: nil, preferredStyle:UIAlertController.Style.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { UIAlertAction in
                            self.removeFromParent()
                            self.view.removeFromSuperview()
                        }))
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
        if CreateOffer.newIdOffer != 0 {
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




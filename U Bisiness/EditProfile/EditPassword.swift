//
//  EditPassword.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.07.2021.
//

import UIKit



class EditPassword: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var oldView: UIView!
    @IBOutlet weak var oldPassword: UITextField!
    @IBOutlet weak var oldLines: UIView!
    
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newLines: UIView!
    
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var confirmLines: UIView!
    
    
    @IBOutlet weak var button: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        bounceScroll(scrollView: scrollView)
        
    
        navigationItem.backBarButtonItem?.tintColor = .black
        oldView.backgroundColor = .vanillaWhite
        oldPassword.autocorrectionType = .no
        newView.backgroundColor = .vanillaWhite
        newPassword.autocorrectionType = .no
        confirmView.backgroundColor = .vanillaWhite
        confirmPassword.autocorrectionType = .no
        button.layer.cornerRadius = 5
        
        let alertController = UIAlertController(title: "В разработке", message: "Для смены пароля используется только строка 'Новый пароль'", preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
   
    
    @IBAction func actionButton(_ sender: UIButton) {
        print("actionButton")
        changePassword(url: "https://ubusiness-ithub.ru/api/changePassword")
    }
    
    
    struct ChangePassword: Codable {
        var ru: String?
        var en: String?
        var de: String?
    }
    
    func changePassword(url: String) {
        let url = NSURL(string: url)!
        let newPassword: String = newPassword.text ?? ""
       
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters: [String: Any]? = ["newPassword": newPassword]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters!, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                let nsHTTPResponse = response as? HTTPURLResponse
                let statusCode = nsHTTPResponse?.statusCode
                if let error = error {
                    print ("\(error)")
                }
                
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(ChangePassword.self, from: data)
                        DispatchQueue.main.async {
                            print("fewgwer")
                            print(newPassword)
                            if statusCode == 200 {
                                DispatchQueue.main.async {
//                                  self.activityIndicator.stopAnimating()
                                    let alert = UIAlertController(title: json.ru ?? "", message: nil, preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            } else if statusCode == 401 {
                                DispatchQueue.main.async {
//                                 self.activityIndicator.stopAnimating()
                                    let alert = UIAlertController(title: "Ошибка авторизации", message: nil, preferredStyle: UIAlertController.Style.alert)
                                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                                    self.present(alert, animated: true, completion: nil)
                                }
                            }
                           
                            print("fegergew")
                        }
                    } catch let error as NSError {
                        print (error.localizedDescription)
                    }
                }
            })
            task.resume()
        } catch _ {
            print("Незадокументированная ошибка")
        }
    }
    
    
}


/*

 */

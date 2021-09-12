//
//  OfferPage.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 24.06.2021.
//

import UIKit

class OfferPage: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var hiddenContenView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        offersFetchId()
        
        colorVanilla(view: view, scrollView: scrollView, contentView: hiddenContenView)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        profileView.backgroundColor = .vanillaWhite
        container.backgroundColor = .vanillaWhite
        label.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.6)
        label.backgroundColor = .vanillaWhite
        scrollView.contentInsetAdjustmentBehavior = .never
//        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        button.layer.cornerRadius = 5
    }

    @IBAction func buttonAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "В разработке", message: "Возможны ошибки", preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func left(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func right(_ sender: UIBarButtonItem) {
        
    }
    
}


struct offerPage: Codable {
    var id: Int?
    var imgurl: String?
    var title: String?
    var `protocol`: String?
    var timecreation: String?
    var term: String?
    var idcreator: Int?
    var text: String?
    var type: String?
}

extension OfferPage {
    func offersFetchId() {
        let id = UserDefaults.standard.integer(forKey: "idOfferClick")
        print("id: \(id)")
        var request = URLRequest.init(url: NSURL(string: "https://ubusiness-ithub.ru/api/fetchOffer?id=\(id)")! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try? JSONDecoder().decode(offerPage.self, from: data)
                    DispatchQueue.main.async {
                        centerLabel.text = json?.title
                        bottomLabel.text = "ДО \(json?.term ?? "")"
                        profileImageView.downloaded(from: "https://ubusiness-ithub.ru/offers/\(json?.imgurl ?? "")")
                        label.text = json?.text
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}

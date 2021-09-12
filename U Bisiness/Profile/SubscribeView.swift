//
//  SubscribeView.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 19.08.2021.
//

import UIKit

class SubscribeView: UIViewController {

    
    // Navigations menu
    @IBOutlet weak var headerTextCabinet: UILabel!
    @IBOutlet weak var headerButtonCabinet: UIButton!
    
    // Card
    @IBOutlet weak var headerTextCard: UILabel!
    @IBOutlet weak var headerButtonCard: UIButton!
    
    // Offer
    @IBOutlet weak var headerTextOffer: UILabel!
    @IBOutlet weak var headerButtonOffer: UIButton!
    
    // Views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var headerCard: UIView!
    
    // Content
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var extend: UIButton!
    @IBOutlet weak var change: UIButton!
    @IBOutlet weak var cancel: UIButton!
    var abc: [StatusSubscribe]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userId = UserDefaults.standard.integer(forKey: "idUser")
        fetchSubscribe(url: "https://join.u-business.world/wp-admin/admin-ajax.php?action=get_orders&u-member-id=\(userId)")
        
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
        cardView.backgroundColor = .vanillaWhite
        headerCard.backgroundColor = .vanillaWhiteContrast
        
        scrollView.alwaysBounceVertical = true
        extend.layer.cornerRadius = 5
        change.backgroundColor = .clear
        change.layer.borderWidth = 2
        change.layer.borderColor = UIColor.black.cgColor
        change.layer.cornerRadius = 5
        
        headerCard.layer.cornerRadius = 5
        headerCard.clipsToBounds = true
        
    }
    
    // Navigator menu
    @IBAction func actionCabinet(_ sender: UIButton) {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
    @IBAction func actionCard(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingCard")
        setSubView(vc!)
    }
    
    @IBAction func actionOffer(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingOffer")
        setSubView(vc!)
    }
    
    
    // Buttons
    @IBAction func actionExtend(_ sender: UIButton) {
        print("actionExtend")
    }
    
    @IBAction func actionChange(_ sender: UIButton) {
        print("actionChange")
    }
    
    @IBAction func actionCancel(_ sender: UIButton) {
        print("actionCancel")
    }
    
    
    
    // MARK: - ServerStatusElement
    struct StatusSubscribe: Decodable {
        var data: DataSubscribe?
        var items: ItemsSubscribe?
    }
    struct DataSubscribe: Decodable {
        var id: Int?
        var status: String?
    }
    struct ItemsSubscribe: Codable {
        var the3: ItemSubscribe?
        
        enum CodingKeys: String, CodingKey {
            case the3 = "3"
        }
    }
    struct ItemSubscribe: Codable {
        var product_id: Int?
    }
    
    typealias typeNetwork = [StatusSubscribe]
    
    
    
    func fetchSubscribe(url: String) {
        let url = URL(string: url)!
        var strValue = 0
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                let json = try JSONDecoder().decode(typeNetwork.self, from: data)
                abc = json
                
                
                DispatchQueue.main.async {
                    
                    print("jspn \(json)")
                    
                    if abc?.isEmpty == true{
                        let alertController = UIAlertController(title: "API вернуло пустой массив", message: nil, preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default))
                        self.present(alertController, animated: true, completion: {
                            titleLabel.text = "Ошибка загрузки"
                        })
                        
                    } else if abc?.isEmpty == false {
                        strValue = json[0].items?.the3?.product_id ?? 0
                        
                        switch strValue {
                        case 244: titleLabel.text = "Тариф VIP 1 год"
                        case 247: titleLabel.text = "Тариф VIP 6 месяцев"
                        case 241: titleLabel.text = "Тариф Базовый 6 месяцев"
                        case 238: titleLabel.text = "Тариф Базовый 1 год"
                        default:
                            break
                        }
                        
                        
                       
                    }
                }
                
            } catch let error {
                print("Ошибка: \(error)")
            }
        }.resume()
    }
    
}

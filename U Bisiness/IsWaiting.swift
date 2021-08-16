//
//  IsWaiting.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 08.04.2021.
//

import UIKit

// MARK: - ServerStatusElement
struct ServerStatusElement: Decodable {
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Decodable {
    var id: Int?
    var status: String?
}

class IsWaiting: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var pay: UIButton!
    

    typealias typeNetwork = [ServerStatusElement]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pay.layer.cornerRadius = 5
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        bounceScroll(scrollView: scrollView)
        
        fetchSubscribe(url: "https://join.u-business.world/wp-admin/admin-ajax.php?action=get_orders&u-member-id=5")
    }
    
    @IBAction func payAction(_ sender: UIButton) {
        let urlStringId: String = "https://join.u-business.world/shop/?member=\(SingIn.idUserForPayments)"
        if let url = URL(string: urlStringId) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
    var a = ""
}


extension IsWaiting {
    func fetchSubscribe(url: String) {
        
        
        
        
        let url = URL(string: url)!
        
        URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                
                let json = try JSONDecoder().decode(typeNetwork.self, from: data)
                a = json.first?.data?.status ?? ""
                
                if json.first?.data?.status ?? "" == "completed" {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(true, forKey: "Auth")
                        
                        let vc = storyboard?.instantiateViewController(identifier: "MainViewController")
                        navigationController?.pushViewController(vc!, animated: true)
                        UserDefaults.standard.setValue(SingIn.idUserForPayments, forKey: "idUser")
                    }
                } else {
                    
                }
                
                
            } catch let error {
                print("Ошибка: \(error)")
            }
        }.resume()
    }
}

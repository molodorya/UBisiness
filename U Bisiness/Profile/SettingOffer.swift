//
//  SettingOffer.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 30.07.2021.
//

import UIKit

class SettingOffer: UIViewController {
  
    // Content
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    // Cabinet
    @IBOutlet weak var headerTextCabinet: UILabel!
    @IBOutlet weak var headerButtonCabinet: UIButton!
    
    // Card
    @IBOutlet weak var headerTextCard: UILabel!
    @IBOutlet weak var headerButtonCard: UIButton!
    
    // Offer
    @IBOutlet weak var headerTextOffer: UILabel!
    @IBOutlet weak var headerButtonOffer: UIButton!
    
    
    @IBOutlet weak var actual: UIButton!
    @IBOutlet weak var overdue: UIButton!
    
    
    @IBOutlet weak var add: UIButton!
    
    var offersUser: [offerType]?
    static var countCell = 0
    
    
    static var selectCardId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offerFetch(url: "https://ubusiness-ithub.ru/api/fetchUserOffers")
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        tableView.backgroundColor = .vanillaWhite
        headerView.backgroundColor = .vanillaWhite
        
        add.layer.cornerRadius = 5
        
        tableView.delegate = self
        tableView.dataSource = self
        
        actual.backgroundColor = .vanillaWhiteContrast
        overdue.backgroundColor = .clear
        
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
    
    @IBAction func actionCabinet(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingProfile")
        setSubView(vc!)
        print("1")
        
    }
    
    @IBAction func actionCard(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingCard")
        setSubView(vc!)
        print("2")
    }
    
    
    @IBAction func actualAction(_ sender: UIButton) {
        actual.backgroundColor = .vanillaWhiteContrast
        actual.setTitleColor(.black, for: .normal)
        
        overdue.backgroundColor = .clear
        overdue.setTitleColor(.lightGray, for: .normal)
        
        add.isHidden = false
        offerFetch(url: "https://ubusiness-ithub.ru/api/fetchUserOffers")
    }
    
    
    @IBAction func overdueAction(_ sender: UIButton) {
        overdue.backgroundColor = .vanillaWhiteContrast
        actual.backgroundColor = .clear
        
        overdue.setTitleColor(.black, for: .normal)
        actual.setTitleColor(.lightGray, for: .normal)
        
        add.isHidden = true
        
        offerFetchOld(url: "https://ubusiness-ithub.ru/api/fetchHistoryOffers")
        print(SettingOffer.countCell)
        
    }
    
    @IBAction func addClick(_ sender: UIButton) {
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
  
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] {
                let newSize = newValue as! CGSize
                self.tableViewHeight.constant = newSize.height
            }
        }
    }
}

extension SettingOffer: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOffer.countCell
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 20
       }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let index = offersUser?[indexPath.row] {
            UserDefaults.standard.setValue(index[indexPath.section].id ?? 0, forKey: "selectCardId")
        }
    }
    
    
    


    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celling", for: indexPath) as! TableScroll
        
        cell.layer.cornerRadius = 5
       
        if let data = offersUser?[indexPath.row] {
            cell.titleCell.text = data[indexPath.section].title
            cell.protocolCell.text = data[indexPath.section].protocol ?? ""
        }
        
        
        cell.contentView.backgroundColor = UIColor.random.withAlphaComponent(0.8)
        
        switch indexPath.section {
        case 0:
            cell.contentView.backgroundColor = .red.withAlphaComponent(0.8)
        case 1:
            cell.contentView.backgroundColor = .purple.withAlphaComponent(0.8)
        case 2:
            cell.contentView.backgroundColor = .cyan.withAlphaComponent(0.8)
        case 3:
            cell.contentView.backgroundColor = .orange.withAlphaComponent(0.8)
        default:
            break
        }
        
    
        return cell
    }
}

class TableScroll: UITableViewCell {
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var protocolCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleCell.adjustsFontSizeToFitWidth = true
        protocolCell.adjustsFontSizeToFitWidth = true
    }
    
}



extension SettingOffer {
    struct OfferStruct: Codable {
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

    typealias offerType = [OfferStruct]
    
        func offerFetch(url: String) {
            var request = URLRequest.init(url: NSURL(string: url)! as URL)
            request.httpMethod = "GET"
            request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let config = URLSessionConfiguration.default
            let session = URLSession.init(configuration: config)
            
            let task = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(offerType.self, from: data)
                        offersUser = [json]
                       
                        DispatchQueue.main.async {
                            SettingOffer.countCell = json.endIndex
                            print(SettingOffer.countCell)
                            tableView.reloadData()
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            })
            task.resume()
        }
    
    func offerFetchOld(url: String) {
        var request = URLRequest.init(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(offerType.self, from: data)
                    offersUser = [json]
                   
                    DispatchQueue.main.async {
                        SettingOffer.countCell = json.endIndex
                        
                        if SettingOffer.countCell == 0 {
                            let alertController = UIAlertController(title: "Просроченных предложений нету", message: nil, preferredStyle:UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                        tableView.reloadData()
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
    

}
extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

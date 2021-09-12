//
//  Promotions.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 15.06.2021.
//

import UIKit

protocol PromotionsDelegate: AnyObject {
    func didTapMenuButton()
}


class PromotionsCell: UITableViewCell {
    @IBOutlet weak var imagePromotions: UIImageView!
    @IBOutlet weak var titlePromotions: UILabel!
    @IBOutlet weak var datePromotions: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        imagePromotions.layer.cornerRadius = 30
        contentView.backgroundColor = UIColor.vanillaWhite
        
    }
}


class Promotions: UITableViewController {
    
 
    
    static let cellName = "promotionsCell"

    var offer: [offerSearchType]?
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var buttonHeader: UIButton!
    @IBOutlet weak var batButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        offerFetch(url: "https://ubusiness-ithub.ru/api/fetchOffers")
        headerView.backgroundColor = UIColor.vanillaWhite
        searchView.backgroundColor = .vanillaWhite
        searchTextField.backgroundColor = .vanillaWhite
        searchTextField.indent(size: 20)
        searchTextField.placeholder = "Поиск"
        searchTextField.layer.masksToBounds = true
        tableView.separatorStyle = .none
        searchView.layer.cornerRadius = 5
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.black.cgColor
        view.backgroundColor = UIColor.vanillaWhite
        burAction(.init())
        hideKeyboardWhenTappedScreen()
        
        navigationController?.navigationBar.barTintColor = .vanillaWhite
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.shadowImage = UIImage()
        
      
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
   
    
    
    @IBAction func burAction(_ sender: UIBarButtonItem) {
        batButton.target = revealViewController()
        batButton.action = #selector(revealViewController()?.revealSideMenu)
    }
    
 
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        isSearch = true
        offerSearch(url: "https://ubusiness-ithub.ru/api/searchoffers")
    }
    
    
    
    @IBAction func actionButtonHeader(_ sender: UIButton) {
        print("actionButtonHeader")
    }
    
    var isSearch = false
    var countSearch = 0
    var countCell = 0
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if isSearch == true {
            return 1
        } else {
            return countCell
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearch == true {
            return countSearch
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if isSearch == true {
            if let idCard = offer?[indexPath.section] {
            
                UserDefaults.standard.setValue(idCard[indexPath.row].id ?? 0, forKey: "idOfferClick")
                
                let vc = storyboard?.instantiateViewController(identifier: "OfferPage")
                vc?.modalPresentationStyle = .fullScreen
                present(vc!, animated: true, completion: nil)
            }
        } else {
            if let idCard = offer?[indexPath.row] {
            
                UserDefaults.standard.setValue(idCard[indexPath.section].id ?? 0, forKey: "idOfferClick")
                
                let vc = storyboard?.instantiateViewController(identifier: "OfferPage")
                vc?.modalPresentationStyle = .fullScreen
                present(vc!, animated: true, completion: nil)
            }
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Promotions.cellName, for: indexPath) as! PromotionsCell
        
        if isSearch == true {
            if let search = offer?[indexPath.section] {
                cell.titlePromotions.text = search[indexPath.row].title
                cell.datePromotions.text = "ДО \(search[indexPath.row].term ?? "")"
                cell.imagePromotions.image = nil
                cell.imagePromotions.downloaded(from: "https://ubusiness-ithub.ru/offers/\(search[indexPath.row].imgurl ?? "")")
            }
            
        } else {
            if let notSearch = offer?[indexPath.row] {
                cell.titlePromotions.text = notSearch[indexPath.section].title
                cell.datePromotions.text = "ДО \(notSearch[indexPath.section].term ?? "")"
                cell.imagePromotions.image = nil
                cell.imagePromotions.downloaded(from: "https://ubusiness-ithub.ru/offers/\(notSearch[indexPath.section].imgurl ?? "")")

            }
        }
        
        return cell
    }
}

struct OfferSearch: Codable {
    var id: Int?
    var imgurl: String?
    var title: String?
    var welcomeProtocol: String?
    var timecreation: String?
    var term: String?
    var text: String?
    var idcreator: Int?
    var type: String?
}

typealias offerSearchType = [OfferSearch]


extension Promotions {
    func offerFetch(url: String) {
        var request = URLRequest.init(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(offerSearchType.self, from: data)
                    self.offer = [json]

                    DispatchQueue.main.async {
                        self.countCell = json.endIndex
                        self.tableView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
        })
        task.resume()
    }
    
    func offerSearch(url: String) {
        let parameters: [String: Any] = ["word": searchTextField.text ?? ""]

        let url = NSURL(string: url)!
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: url as URL)
        
        request.httpMethod = "POST"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions())
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            let nsHTTPResponse = response as! HTTPURLResponse
            let statusCode = nsHTTPResponse.statusCode
            if let data = data {
                print(statusCode)
                do {
                    let json = try JSONDecoder().decode(offerSearchType.self, from: data)
                    
                    self.offer = [json]
                    
                    DispatchQueue.main.async {
                        self.countSearch = json.endIndex
                        self.tableView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
 
}

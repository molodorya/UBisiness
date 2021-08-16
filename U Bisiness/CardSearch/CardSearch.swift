//
//  CardSearch.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 05.08.2021.
//

import UIKit

class CardCell: UITableViewCell {
    

    @IBOutlet weak var avatarurl: UIImageView!
    @IBOutlet weak var user: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var status: UIImageView!
    @IBOutlet weak var industry: UILabel!
    
  
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        avatarurl.layer.cornerRadius = 35
    }
}

class CardSearch: UIViewController {
  
 
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeader: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var chosenButton: UIButton!

    var cards: [FetchBusinessCards]?
    
    var countCell = 0
    var idCard = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBusinessCards(url: "https://ubusiness-ithub.ru/api/fetchBusinessCards")
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        contentViewHeader.backgroundColor = .vanillaWhite
        tableView.backgroundColor = .vanillaWhite
        
        allButton.backgroundColor = .vanillaWhiteContrast
        chosenButton.backgroundColor = .clear
        allButton.layer.cornerRadius = 5
        chosenButton.layer.cornerRadius = 5
    
        navigationItem.backBarButtonItem?.tintColor = .black
        
        searchTextField.layer.masksToBounds = true
        
        searchView.layer.cornerRadius = 5
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.black.cgColor

        searchTextField.backgroundColor = .vanillaWhite
        searchView.backgroundColor = .vanillaWhite
        searchTextField.indent(size: 20)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        hideKeyboardWhenTappedScreen()
        
        menuAction(.init())
       
    }
 
    var isSearch = false
    var countSearch = 0
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        print("search...")
        isSearch = true
        
        if isSearch == false && searchTextField.text?.count == 0 {
            all(.init())
        }
        
        
        searchBusinessCard(url: "https://ubusiness-ithub.ru/api/searchBusinessCards")
        allButton.backgroundColor = .vanillaWhiteContrast
        chosenButton.backgroundColor = .clear
        CardSearch.add_delete = false
        
    }
    
    @IBAction func textFieldDidEnd(_ sender: UITextField) {
        print("return")
      
    }
    
    
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        menu.target = revealViewController()
        menu.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        if CardSearch.add_delete == true {
            fetchFavoriteCard(url: "https://ubusiness-ithub.ru/api/fetchFavoritesCards")
        }
        
    
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
       
    static var add_delete = false
    
    @IBAction func all(_ sender: UIButton) {
        allButton.backgroundColor = .vanillaWhiteContrast
        chosenButton.backgroundColor = .clear
        CardSearch.add_delete = false
        fetchBusinessCards(url: "https://ubusiness-ithub.ru/api/fetchBusinessCards")
        
    }
    
    @IBAction func chosen(_ sender: UIButton) {
        chosenButton.backgroundColor = .vanillaWhiteContrast
        allButton.backgroundColor = .clear
        CardSearch.add_delete = true
        isSearch = false
        fetchFavoriteCard(url: "https://ubusiness-ithub.ru/api/fetchFavoritesCards")
        
       
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] {
                let newSize = newValue as! CGSize
                self.tableHeight.constant = newSize.height
            }
        }
    }
}


extension CardSearch: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("countCell \(countCell)")
        print("countSearch \(countSearch)")
        
        if isSearch == true {
            return countSearch
        } else {
            return 1
        }
        
       
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if isSearch == true {
            return 1
        } else {
            return countCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath: \(indexPath.section)")
        
        if isSearch == true {
            if let idCard = cards?[indexPath.section] {
                print("IdCard: \(idCard[indexPath.section].idCard ?? 0)")
                
                UserDefaults.standard.setValue(idCard[indexPath.section].idCard ?? 0, forKey: "idCardClick")
            }
        } else {
            if let idCard = cards?[indexPath.row] {
                print("IdCard: \(idCard[indexPath.section].idCard ?? 0)")
                
                UserDefaults.standard.setValue(idCard[indexPath.section].idCard ?? 0, forKey: "idCardClick")
            }
        }
        
        
    }

    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        

        if let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardCell {
            switch indexPath.section {
            case 0...1:
                cell.backgroundColor = .vanillaWhiteContrast
            case 1...:
                cell.backgroundColor = .vanillaWhite
            default:
                break
            }
         
            
//            if let avatar = cards?[indexPath.row] {
//
//            }
            if isSearch == true {
                if let nameUser = cards?[indexPath.section] {
                    if nameUser[indexPath.section].user?.count ?? 0 <= 2 {
                        cell.user.text = "—"
                    } else {
                        cell.user.text = nameUser[indexPath.section].user
                    }
                }
                if let statusUser = cards?[indexPath.section] {
                    if statusUser[indexPath.section].status == true {
                        cell.status.isHidden = false
                    } else {
                        cell.status.isHidden = true
                    }
                }

                if let company = cards?[indexPath.section] {

                    if company[indexPath.section].company?.count ?? 0 <= 2 {
                        cell.company.text = "—"
                    } else {
                        cell.company.text = company[indexPath.section].company
                    }
                }

                if let industry = cards?[indexPath.section] {
                    if industry[indexPath.section].industry?.count ?? 0 <= 2 {
                        cell.industry.text = "—"
                    } else {
                        cell.industry.text = industry[indexPath.section].industry
                    }
                }
            } else {
                if let nameUser = cards?[indexPath.row] {
                    if nameUser[indexPath.section].user?.count ?? 0 <= 2 {
                        cell.user.text = "—"
                    } else {
                        cell.user.text = nameUser[indexPath.section].user
                    }
                }
                if let statusUser = cards?[indexPath.row] {
                    if statusUser[indexPath.section].status == true {
                        cell.status.isHidden = false
                    } else {
                        cell.status.isHidden = true
                    }
                }

                if let company = cards?[indexPath.row] {

                    if company[indexPath.section].company?.count ?? 0 <= 2 {
                        cell.company.text = "—"
                    } else {
                        cell.company.text = company[indexPath.section].company
                    }
                }

                if let industry = cards?[indexPath.row] {
                    if industry[indexPath.section].industry?.count ?? 0 <= 2 {
                        cell.industry.text = "—"
                    } else {
                        cell.industry.text = industry[indexPath.section].industry
                    }
                }
            }
            
            
           

            return cell
        }
        
        return UITableViewCell()
    }
}

struct FetchBusinessCard: Codable {
    var idCard: Int?
    var user, avatarurl: String?
    var status: Bool?
    var company, industry: String?
    
    enum CodingKeys: String, CodingKey {
        case idCard = "id_card"
        case user, avatarurl, status, company, industry
    }
}

typealias FetchBusinessCards = [FetchBusinessCard]

extension CardSearch {
    // All card
    func fetchBusinessCards(url: String) {
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
                    
                    let json = try JSONDecoder().decode(FetchBusinessCards.self, from: data)
                    self.cards = [json]
                    print(json)
                    
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

}


struct FetchFavoriteCard: Codable {
    var idCard: Int?
    var user, avatarurl: String?
    var status: Bool?
    var company, industry: String?
    
    enum CodingKeys: String, CodingKey {
        case idCard = "id_card"
        case user, avatarurl, status, company, industry
    }
}

typealias FetchFavoriteCardType = [FetchFavoriteCard]


// Favorite
extension CardSearch {
    func fetchFavoriteCard(url: String) {
        var request = URLRequest.init(url: NSURL(string: "https://ubusiness-ithub.ru/api/fetchFavoritesCards")! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(FetchBusinessCards.self, from: data)
                    self.cards = [json]
                    
                    DispatchQueue.main.async {
                        self.countCell = json.endIndex
                        
                        self.tableView.reloadData()
                    }
                    
                    
                    print(json)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}



// Search
extension CardSearch {
    func searchBusinessCard(url: String) {
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
                    let json = try JSONDecoder().decode(FetchBusinessCards.self, from: data)
                    self.cards = [json]
                    
                    DispatchQueue.main.async {
                        self.countSearch = json.endIndex
                        self.tableView.reloadData()
                    }
                    
                    
                    print(json)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

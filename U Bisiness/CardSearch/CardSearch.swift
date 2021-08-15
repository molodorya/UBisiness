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
        searchTextField.layer.cornerRadius = 5
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.black.cgColor
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
    
    
    @IBAction func menuAction(_ sender: UIBarButtonItem) {
        menu.target = revealViewController()
        menu.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    @IBAction func all(_ sender: UIButton) {
        allButton.backgroundColor = .vanillaWhiteContrast
        chosenButton.backgroundColor = .clear
        
        
    }
    
    @IBAction func chosen(_ sender: UIButton) {
        chosenButton.backgroundColor = .vanillaWhiteContrast
        allButton.backgroundColor = .clear
        
//        fetchFavoriteBusinessCard(url: "https://ubusiness-ithub.ru/api/fetchFavoritesCards")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            let alert = UIAlertController(title: "The data couldn’t be read because it isn’t in the correct format.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            vibrationFunc(tapping: .heavy)
        }
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
        
        return 1
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
   
        return countCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath: \(indexPath.section)")

        
        if let idCard = cards?[indexPath.row] {
            print("IdCard: \(idCard[indexPath.section].idCard ?? 0)")
            
            UserDefaults.standard.setValue(idCard[indexPath.section].idCard ?? 0, forKey: "idCardClick")
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
              
            
            if let avatar = cards?[indexPath.row] {
                func downloadedFrom(link: String, imageView: UIImage) {
                    guard let url = URL(string: link) else { return }
                    URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
                        guard let data = data , error == nil, let image = UIImage(data: data) else { return }
                        DispatchQueue.main.async { () -> Void in
                            cell.avatarurl.image = image
                        }
                    }).resume()
                }
            }
            
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
    
    // Favorite card
    func fetchFavoriteBusinessCard(url: String) {
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
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}

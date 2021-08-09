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

class Promotions: UITableViewController {
    
    weak var delegate: PromotionsDelegate?
    
    static let cellName = "promotionsCell"
    
    let linesImage = UIImage(systemName: "list.dash")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    let userImage = UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var buttonHeader: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingHeaderView()
        settingTableView()
        settingSearchTextField()
        view.backgroundColor = UIColor.vanillaWhite
        
        fetchOffers()
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
        
        
    }
    
    @objc func user() {
        print("user")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: linesImage, style: .plain, target: self, action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: userImage, style: .plain, target: self, action: #selector(user))
        
        navigationController?.navigationBar.barTintColor = UIColor.vanillaWhite
    }
    
    
    @IBAction func actionButtonHeader(_ sender: UIButton) {
        print("actionButtonHeader")
    }
    
    
    
    
    func settingHeaderView() {
        headerView.backgroundColor = UIColor.vanillaWhite
    }
    
    func settingSearchTextField() {
        searchTextField.indent(size: 20)
        searchTextField.placeholder = "Поиск"
        
        searchTextField.layer.cornerRadius = 5
        searchTextField.layer.borderWidth = 2.0
        searchTextField.layer.borderColor = UIColor.gray.cgColor
        searchTextField.layer.masksToBounds = true
    }
    
    func settingTableView() {
        tableView.separatorStyle = .none
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Promotions.cellName, for: indexPath) as! PromotionsCell
        
        cell.titlePromotions.text = FetchOffersEnum.title
      

        
        return cell
    }
    
    //MARK: - Обработка касаний ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        vibrationFunc(tapping: .light)
       
        print("Нажата ячейка №\(indexPath.row)")
    }
    
    

    
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

extension Promotions {
    
    struct FetchOffersStruct: Codable {
        var id: Int?
        var img, title, fetchOffersElementProtocol, timecreation: String?
        var term, text: String?
        var idcreator: Int?
    }
    
    enum FetchOffersEnum {
        static var id = 0
        static var img = ""
        static var title = ""
        static var fetchOffersElementProtocol = ""
        static var timecreation = ""
        static var term = ""
        static var text = ""
        static var idcreator = ""
    }
    
    func fetchOffers() {
        let session = URLSession.shared
        let url = URL(string: "https://ubusiness-ithub.ru/api/fetchOffers")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken!)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                let json = try JSONDecoder().decode([FetchOffersStruct].self, from: data!)
                FetchOffersEnum.id = json[0].id ?? 0
                FetchOffersEnum.img = json[0].img ?? "-"
                FetchOffersEnum.title = json[0].title ?? "-"
                FetchOffersEnum.fetchOffersElementProtocol = json[0].fetchOffersElementProtocol ?? "-"
                FetchOffersEnum.timecreation = json[0].timecreation ?? "-"
                FetchOffersEnum.text = json[0].text ?? "-"
                FetchOffersEnum.id = json[0].idcreator ?? 0
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
}


//
//  NewsStoryboard.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.06.2021.
//
import UIKit




struct SearchNews: Codable {
    var id: Int?
    var title: String?
    var date: String?
    var banner: String?
    var type: String?
}

typealias searchType = [SearchNews]

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var promptNews: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        viewCell.backgroundColor = .vanillaWhite
        imageNews.clipsToBounds = true
        imageNews.layer.cornerRadius = 30
        
      
        
        contentView.backgroundColor = UIColor.vanillaWhite
        
    }
}


class News: UITableViewController {
    
    static let cellName = "newsCell"
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var buttonTitleImage: UIButton!
    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    
    var news: [searchType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsFetch(url: "https://ubusiness-ithub.ru/api/fetchnewslist")
       
        
        
        view.backgroundColor = UIColor.vanillaWhite
        searchView.backgroundColor = .vanillaWhite
        searchTextField.backgroundColor = .vanillaWhite
//        searchTextField.layer.cornerRadius = 5
        headerView.backgroundColor = UIColor.vanillaWhite
        searchTextField.indent(size: 20)
        searchTextField.placeholder = "Поиск"
        
  
        searchTextField.layer.masksToBounds = true
        searchTextField.indent(size: 20)
        searchTextField.placeholder = "Поиск"
        
        searchView.layer.cornerRadius = 5
        searchView.layer.borderWidth = 2.0
        searchView.layer.borderColor = UIColor.gray.cgColor
        
        searchTextField.layer.masksToBounds = true
        title = "новости"
        tableView.separatorStyle = .none
        buttonTitleImage.contentMode = .scaleAspectFill
        buttonTitleImage.clipsToBounds = true
        buttonTitleImage.contentMode = .scaleAspectFill
        // Use setBackgroundImage or setImage
//        buttonTitleImage.setBackgroundImage(UIImage(named: "crimea"), for: .normal)
        titleButton.textColor = .white
        titleButton.text = "Может ли самозанятый платить НДП с процентов по займам"
        titleButton.adjustsFontSizeToFitWidth = true
        buttonTitleImage.addTarget(self, action: #selector(btnTitleImage), for: .touchDown)
        hideKeyboardWhenTappedScreen()
        
        navigationController?.navigationBar.barTintColor = .vanillaWhite
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.shadowImage = UIImage()
        
        actionMenu(.init())
        

        
    }
    
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        isSearch = true
        searchNews(url: "https://ubusiness-ithub.ru/api/searchnews")
    }
    
    
    @IBAction func actionMenu(_ sender: UIBarButtonItem) {
        menu.target = revealViewController()
        menu.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    @IBAction func actionFilter(_ sender: UIBarButtonItem) {
        
    }
    

    
    @objc func btnTitleImage() {
        
        print("fe")
    }

    
    var isSearch = false
    var countSearch = 0
    var countCell = 0

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
        
        
        if isSearch == true {
            if let idCard = news?[indexPath.section] {
            
                UserDefaults.standard.setValue(idCard[indexPath.row].id ?? 0, forKey: "idNewsClick")
                
                let vc = storyboard?.instantiateViewController(identifier: "NewsPage")
                vc?.modalPresentationStyle = .fullScreen
                present(vc!, animated: true, completion: nil)
            }
        } else {
            if let idCard = news?[indexPath.row] {
            
                UserDefaults.standard.setValue(idCard[indexPath.section].id ?? 0, forKey: "idNewsClick")
                
                let vc = storyboard?.instantiateViewController(identifier: "NewsPage")
                vc?.modalPresentationStyle = .fullScreen
                present(vc!, animated: true, completion: nil)
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: News.cellName, for: indexPath) as! NewsCell

        if isSearch == true {
            if let title = news?[indexPath.section] {
                cell.titleNews.text = title[indexPath.row].title
                cell.dateNews.text = title[indexPath.row].date
                cell.promptNews.text = title[indexPath.row].type
                cell.imageNews.image = nil
                cell.imageNews.downloaded(from: "https://ubusiness-ithub.ru/news/\(title[indexPath.row].banner ?? "")")
            }
        } else {
            if let title = news?[indexPath.row] {
                cell.titleNews.text = title[indexPath.section].title
                cell.dateNews.text = title[indexPath.section].date
                cell.promptNews.text = title[indexPath.section].type
                cell.imageNews.image = nil
                cell.imageNews.downloaded(from: "https://ubusiness-ithub.ru/news/\(title[indexPath.section].banner ?? "")")
            }
        }
        

        return cell
    }
}





extension News {
    func newsFetch(url: String) {
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
                    let json = try JSONDecoder().decode(searchType.self, from: data)
                    self.news = [json]
                    
                    DispatchQueue.main.async {
                        self.countCell = json.endIndex
                        tableView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }

    
    
    
    
    func searchNews(url: String) {
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
                do {
                    let json = try JSONDecoder().decode(searchType.self, from: data)
                    
                    self.news = [json]
                    
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


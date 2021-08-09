//
//  NewsStoryboard.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.06.2021.
//


//MARK: - Storyboard
import UIKit

class News: UITableViewController {
    

    
    static let cellName = "newsCell"
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var buttonTitleImage: UIButton!
    
    
    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var promptButton: UILabel!
    

    @IBOutlet weak var menu: UIBarButtonItem!
    @IBOutlet weak var filter: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.vanillaWhite
       
  
        
        DispatchQueue.main.async {
            self.fetchNewsList()
        }
        
        settingHeaderView()
        settingTableView()
        settingButtonTitleImage()
        settingSearchTextField()
        
        settingTitleButton()
        settingPromptButton()
        
        
        
        title = "новости"
        
        hideKeyboardWhenTappedScreen()
        
        actionMenu(.init())
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func actionMenu(_ sender: UIBarButtonItem) {
        menu.target = revealViewController()
        menu.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    @IBAction func actionFilter(_ sender: UIBarButtonItem) {
        
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
    

    
    func settingButtonTitleImage() {
        buttonTitleImage.contentMode = .scaleAspectFill
        buttonTitleImage.clipsToBounds = true
        buttonTitleImage.contentMode = .scaleAspectFill
        // Use setBackgroundImage or setImage
        buttonTitleImage.setBackgroundImage(UIImage(named: "crimea"), for: .normal)
        
        buttonTitleImage.addTarget(self, action: #selector(btnTitleImage), for: .touchDown)
    }
    
    func settingTitleButton() {
        titleButton.textColor = .white
        titleButton.text = "Может ли самозанятый платить НДП с процентов по займам"
        titleButton.adjustsFontSizeToFitWidth = true

//        titleButton.lineBreakMode = NSLineBreakMode.byTruncatingTail
  
    }
    
    func settingPromptButton() {
        promptButton.textColor = .white
        promptButton.text = "29 ФЕВРАЛЯ"
    }
    
    @objc func btnTitleImage() {
        
        print("fe")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: News.cellName, for: indexPath) as! NewsCell

      

        return cell
    }
    
    //MARK: - Обработка касаний ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        vibrationFunc(tapping: .light)

        print("Нажата ячейка №\(indexPath.row)")
    }
}

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var promptNews: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
        imageNews.clipsToBounds = true
        imageNews.layer.cornerRadius = 30
        
        
        contentView.backgroundColor = UIColor.vanillaWhite
        
    }
}


extension News {
    
    struct FetchNewsList: Codable {
        var id: Int
        var title: String
        var date: String
        var banner: String
        var type: String
    }
    
    enum NewsEmum {
        static var id = 0
        static var title = ""
        static var date = ""
        static var banner = ""
        static var type = ""
    }
    
    func fetchNewsList() {
        let session = URLSession.shared
        let url = URL(string: "https://ubusiness-ithub.ru/api/fetchnewslist")!
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
                let json = try JSONDecoder().decode([FetchNewsList].self, from: data!)
                
                NewsEmum.id = json[0].id
                NewsEmum.title = json[0].title
                NewsEmum.date = json[0].date
                NewsEmum.banner = json[0].banner
                NewsEmum.type = json[0].type
                
                
                
                DispatchQueue.main.async {
                    
                    let cell = NewsCell()
                    
                    cell.titleNews.text = NewsEmum.title
                    cell.promptNews.text = NewsEmum.type
                        
                        
//                    let url = URL(string: "https://ubusiness-ithub.ru/api/fetchOffers")
//                    if url != nil {
//                        DispatchQueue.global().async {
//                            let data = try? Data(contentsOf: url!) //убедитесь, что ваше изображение в этом URL-адресе действительно существует, в противном случае разверните его в if let check / try-catch
//                            DispatchQueue.main.async {
//                                if data != nil {
//                                    cell.imageNews.image = UIImage(data:data!)
//                                }else{
//                                    cell.imageNews.image = UIImage(named: "default.png")
//                                }
//                            }
//                        }
//                    }
                
                    cell.dateNews.text = NewsEmum.date
                    self.tableView.reloadData()
                }
                
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
            
        }
        task.resume()
    }
}



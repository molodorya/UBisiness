//
//  NewsStoryboard.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.06.2021.
//
import UIKit

class News: UITableViewController {
    
    static let cellName = "newsCell"
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var buttonTitleImage: UIButton!
    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var menu: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.vanillaWhite
        searchView.backgroundColor = .vanillaWhite
        searchTextField.backgroundColor = .vanillaWhite
//        searchTextField.layer.cornerRadius = 5
        settingHeaderView()
        settingTableView()
        settingButtonTitleImage()
        settingSearchTextField()
        
        settingTitleButton()
                
        
        
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
//        buttonTitleImage.setBackgroundImage(UIImage(named: "crimea"), for: .normal)
        
        buttonTitleImage.addTarget(self, action: #selector(btnTitleImage), for: .touchDown)
    }
    
    func settingTitleButton() {
        titleButton.textColor = .white
        titleButton.text = "Может ли самозанятый платить НДП с процентов по займам"
        titleButton.adjustsFontSizeToFitWidth = true

//        titleButton.lineBreakMode = NSLineBreakMode.byTruncatingTail
  
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
        return Home.news?.endIndex ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexPath: \(indexPath.section)")
        tableView.deselectRow(at: indexPath, animated: true)
        if let id = Home.news?[indexPath.row] {
            UserDefaults.standard.setValue(id.id ?? 0, forKey: "idNewsClick")
        }
        
        
        let vc = storyboard?.instantiateViewController(identifier: "NewsPage")
        vc?.modalPresentationStyle = .fullScreen
        present(vc!, animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: News.cellName, for: indexPath) as! NewsCell

        
        if let title = Home.news?[indexPath.row] {
            cell.titleNews.text = title.title
        }
        
        if let date = Home.news?[indexPath.row] {
            cell.dateNews.text = date.date
        }
        
        if let prompt = Home.news?[indexPath.row] {
            cell.promptNews.text = prompt.type
        }
        
        if let date = Home.news?[indexPath.row] {
            
       
//            cell.dateNews.text = datec
        }
        
        if let id = Home.news?[indexPath.row] {
            print(id.id)
        }
    

        return cell
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

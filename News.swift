//
//  NewsStoryboard.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 14.06.2021.
//


//MARK: - Storyboard
import UIKit

class News: UITableViewController {
    
    let linesImage = UIImage(systemName: "list.dash")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    let userImage = UIImage(systemName: "person")?.withTintColor(.black, renderingMode: .alwaysOriginal)
    
    static let cellName = "newsCell"
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var buttonTitleImage: UIButton!
    
    
    @IBOutlet weak var titleButton: UILabel!
    @IBOutlet weak var promptButton: UILabel!
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.vanillaWhite
       
        
        settingHeaderView()
        settingTableView()
        settingButtonTitleImage()
        settingSearchTextField()
        
        settingTitleButton()
        settingPromptButton()
        
        
        
        title = "новости"
        
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: linesImage, style: .plain, target: self, action: #selector(didTapMenuButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: userImage, style: .plain, target: self, action: #selector(user))
        
        navigationController?.navigationBar.barTintColor = UIColor.vanillaWhite
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @objc func didTapMenuButton() {
        print("lines")
        
      
    }
    
    @objc func user() {
        print("user")
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

//
//  Events.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 15.06.2021.
//

import UIKit

class Events: UITableViewController {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var leftBar: UIBarButtonItem!
    
    static let cellName = "eventsCell"
    override func viewDidLoad() {
        super.viewDidLoad()
        settingHeaderView()
        settingTableView()
        settingSearchTextField()
        view.backgroundColor = UIColor.vanillaWhite
        searchView.backgroundColor = .vanillaWhite
        searchTextField.backgroundColor = .vanillaWhite
        
        hideKeyboardWhenTappedScreen()
        
        leftBar(.init())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
      
        
        navigationController?.navigationBar.barTintColor = UIColor.vanillaWhite
    }
    
    @IBAction func leftBar(_ sender: UIBarButtonItem) {
        leftBar.target = revealViewController()
        leftBar.action = #selector(revealViewController()?.revealSideMenu)
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
        return 3
//            Home.event?.endIndex ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Events.cellName, for: indexPath) as! EventsCell
        
        if let titleNews = Home.event?[indexPath.section] {
            cell.titleNews.text = titleNews[indexPath.section].title
            cell.dateNews.text = titleNews[indexPath.section].date
            cell.categoryNews.text = titleNews[indexPath.section].category
        }
        
        return cell
    }
    
    //MARK: - Обработка касаний ячейки
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Нажата ячейка №\(indexPath.row)")
    }
}


class EventsCell: UITableViewCell {
    
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var categoryNews: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
        imageNews.layer.cornerRadius = 30
        contentView.backgroundColor = UIColor.vanillaWhite
        
    }
}

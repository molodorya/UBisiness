//
//  Menu.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 10.06.2021.
//

import UIKit

protocol MenuDelegate: AnyObject {
    func didSelect(menuItem: Menu.MenuOptions)
}



class Menu: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    weak var delegate: MenuDelegate?
    
    
    enum MenuOptions: String, CaseIterable {
        case personal = "ЛИЧНЫЙ КАБИНЕТ"
        case card = "ВИЗИТКИ"
        case calendar = "КАЛЕНДАРЬ МЕРОПРИЯТИЙ"
        case gift = "СПЕЦ. ПРЕДЛОЖЕНИЯ"
        case news = "НОВОСТИ"
        case library = "БИБЛИОТЕКА"
        case photoLibrary = "ФОТОПЛЕНКА"
        case aboutAs = "О НАС"
        case feedback = "СВЯЗАТЬСЯ С НАМИ"
        case home = "ГЛАВНАЯ СТРАНИЦА"
        
        var imageName: String {
       
            
            
            switch self {
            case .personal:
                return "person.fill"
            case .card:
                return "creditcard"
            case .calendar:
                return "calendar"
            case .gift:
                return "gift"
            case .news:
                return "newspaper"
            case .library:
                return "books.vertical.fill"
            case .photoLibrary:
                return "camera.fill"
            case .aboutAs:
                return "envelope.fill"
            case .feedback:
                return "wave.3.backward.circle.fill"
            case .home:
                return "house.fill"
            }
        }
    }
    
    let grayColor: UIColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = grayColor
        view.backgroundColor = grayColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 30, y: 124, width: 250, height: view.frame.size.height)
    }

    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
        switch indexPath.row {
        case 0...10:
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
            cell.textLabel?.text = MenuOptions.allCases[indexPath.section].rawValue
            cell.textLabel?.textColor = .white
            cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.section].imageName)
            cell.imageView?.tintColor = .white
            cell.backgroundColor = grayColor
            cell.contentView.backgroundColor = grayColor
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.section]
        delegate?.didSelect(menuItem: item)
    }
    

}

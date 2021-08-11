//
//  SideMenuViewController.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 27.07.2021.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var delegate: SideMenuViewControllerDelegate?
    
    var defaultHighlightedCell: Int = 0
    
    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(named: "user")!, title: "ЛИЧНЫЙ КАБИНЕТ"),
        SideMenuModel(icon: UIImage(named: "cards")!, title: "ВИЗИТКИ"),
        SideMenuModel(icon: UIImage(named: "calendar")!, title: "КАЛЕНДАРЬ МЕРОПРИЯТИЙ"),
        SideMenuModel(icon: UIImage(named: "offers")!, title: "СПЕЦ.ПРЕДЛОЖЕНИЯ"),
        SideMenuModel(icon: UIImage(named: "news")!, title: "НОВОСТИ"),
        SideMenuModel(icon: UIImage(named: "library")!, title: "БИБЛИОТЕКА"),
        SideMenuModel(icon: UIImage(named: "photo")!, title: "ФОТОПЛЕНКА"),
        SideMenuModel(icon: UIImage(named: "about")!, title: "О НАС"),
        SideMenuModel(icon: UIImage(named: "contact")!, title: "СВЯЗАТЬСЯ С НАМИ"),
        SideMenuModel(icon: UIImage(named: "home")!, title: "ГЛАВНАЯ СТРАНИЦА"),
    ]
    
    let colorTable = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.9)

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // TableView
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = colorTable
        self.tableView.separatorStyle = .none

        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 1)
            self.tableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
    
        
        // Register TableView Cell
        self.tableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)
        
        // Update TableView with the data
        self.tableView.reloadData()
       
        
    }
}

// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        UITableViewHeaderFooterView.appearance().tintColor = .clear
        
        return 100
    }
    
    
}

// MARK: - UITableViewDataSource

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.titleLabel.text = self.menu[indexPath.row].title
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 16)

        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = .darkGray
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.delegate?.selectedCell(indexPath.row)
    }
}

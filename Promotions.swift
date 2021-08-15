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

@available(iOS 13.0, *)
class Promotions: UITableViewController {
    
    weak var delegate: PromotionsDelegate?
    
    static let cellName = "promotionsCell"

    
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var buttonHeader: UIButton!
    @IBOutlet weak var batButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.backgroundColor = .vanillaWhite
        searchTextField.backgroundColor = .vanillaWhite
        
        settingHeaderView()
        settingTableView()
        settingSearchTextField()
        view.backgroundColor = UIColor.vanillaWhite
        burAction(.init())
        hideKeyboardWhenTappedScreen()
    }
    
    
    @IBAction func burAction(_ sender: UIBarButtonItem) {
        batButton.target = revealViewController()
        batButton.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    @objc func didTapMenuButton() {
        delegate?.didTapMenuButton()
    }
    
    @objc func user() {
        print("user")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        navigationItem.backBarButtonItem?.tintColor = .black
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
        return Home.offers?.endIndex ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let id = Home.offers?[indexPath.row] {
            UserDefaults.standard.setValue(id.id ?? 0, forKey: "idOfferClick")
            
            let vc = storyboard?.instantiateViewController(identifier: "OfferPage")
            vc?.modalPresentationStyle = .fullScreen
            present(vc!, animated: true, completion: nil)
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Promotions.cellName, for: indexPath) as! PromotionsCell
        
        if let title = Home.offers?[indexPath.row] {
            cell.titlePromotions.text = title.title
        }
        
        if let date = Home.offers?[indexPath.row] {
            cell.datePromotions.text = "ДО \(date.term ?? "")"
        }

        return cell
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


//
//  CardSearch.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 05.08.2021.
//

import UIKit

class CardSearch: UIViewController {
    
 
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeader: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    @IBOutlet weak var menu: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        contentViewHeader.backgroundColor = .vanillaWhite
        navigationItem.backBarButtonItem?.tintColor = .black
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? CardCell {
            
            cell.backgroundColor = .vanillaWhite
            
            cell.name.text = "Nikita Molodorya"
            cell.company.text = "Rostelecom"
            cell.specification.text = "Telecommunication"
            
            return cell
        }
        
        return UITableViewCell()
    }
}

class CardCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var specification: UILabel!
    @IBOutlet weak var verification: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        photo.layer.cornerRadius = 50
    }
    
}
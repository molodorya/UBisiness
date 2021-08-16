//
//  SettingOffer.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 30.07.2021.
//

import UIKit

class SettingOffer: UIViewController {
  
    // Content
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var headerView: UIView!
    
    // Cabinet
    @IBOutlet weak var headerTextCabinet: UILabel!
    @IBOutlet weak var headerButtonCabinet: UIButton!
    
    // Card
    @IBOutlet weak var headerTextCard: UILabel!
    @IBOutlet weak var headerButtonCard: UIButton!
    
    // Offer
    @IBOutlet weak var headerTextOffer: UILabel!
    @IBOutlet weak var headerButtonOffer: UIButton!
    
    
    @IBOutlet weak var actual: UIButton!
    @IBOutlet weak var overdue: UIButton!
    
    
    @IBOutlet weak var add: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        tableView.backgroundColor = .vanillaWhite
        headerView.backgroundColor = .vanillaWhite
        
        add.layer.cornerRadius = 5
        
        tableView.delegate = self
        tableView.dataSource = self
        
        actual.backgroundColor = .vanillaWhiteContrast
        overdue.backgroundColor = .clear
        
        // Cabinet
        headerTextCabinet.adjustsFontSizeToFitWidth = true
        headerTextCabinet.text = "мой\nкабинет"
        headerButtonCabinet.backgroundColor = .clear
        
        // Card
        headerTextCard.adjustsFontSizeToFitWidth = true
        headerTextCard.text = "моя\nвизитка"
        headerButtonCard.backgroundColor = .clear
        
        //Offer
        headerTextCabinet.adjustsFontSizeToFitWidth = true
        headerTextOffer.text = "мои спец.\nпредложения"
        headerButtonOffer.backgroundColor = .clear
      
    }
    
    @IBAction func actionCabinet(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingProfile")
        setSubView(vc!)
        print("1")
        
    }
    
    @IBAction func actionCard(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "SettingCard")
        setSubView(vc!)
        print("2")
    }
    
    
    @IBAction func actualAction(_ sender: UIButton) {
        actual.backgroundColor = .vanillaWhiteContrast
        actual.setTitleColor(.black, for: .normal)
        
        overdue.backgroundColor = .clear
        overdue.setTitleColor(.lightGray, for: .normal)
    }
    
    
    @IBAction func overdueAction(_ sender: UIButton) {
        overdue.backgroundColor = .vanillaWhiteContrast
        actual.backgroundColor = .clear
        
        overdue.setTitleColor(.black, for: .normal)
        actual.setTitleColor(.lightGray, for: .normal)
        
    }
    
    @IBAction func addClick(_ sender: UIButton) {
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
    }
  
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] {
                let newSize = newValue as! CGSize
                self.tableViewHeight.constant = newSize.height
            }
        }
    }
}

extension SettingOffer: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 20
       }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celling", for: indexPath) as! TableScroll
        
        cell.layer.cornerRadius = 5
       
        if let title = Home.offers?[indexPath.section] {
            cell.labelCenter.text = title.title
        }
        
        if let date = Home.offers?[indexPath.section] {
            cell.labelBottom.text = "ДО \(date.term ?? "")"
        }
        
        switch indexPath.section {
        case 0:
            cell.contentView.backgroundColor = .red.withAlphaComponent(0.8)
        case 1:
            cell.contentView.backgroundColor = .purple.withAlphaComponent(0.8)
        case 2:
            cell.contentView.backgroundColor = .cyan.withAlphaComponent(0.8)
        case 3:
            cell.contentView.backgroundColor = .orange.withAlphaComponent(0.8)
        default:
            break
        }
        
    
        return cell
    }
}

class TableScroll: UITableViewCell {
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelCenter: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
}

// Fetch offers
extension SettingOffer {
    

}

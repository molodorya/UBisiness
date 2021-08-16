//
//  AboutController.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 16.08.2021.
//

import UIKit

class AboutController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var leftBar: UIBarButtonItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
 


    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .vanillaWhite
        tableView.backgroundColor = .vanillaWhite

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        leftAction(.init())
    }
    
    
    @IBAction func leftAction(_ sender: UIBarButtonItem) {
        leftBar.target = revealViewController()
        leftBar.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    let abouts = ["О нас", "Вопрос #2", "Вопрос #3", "Вопрос #4", "Вопрос #5"]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "about", for: indexPath) as! AboutCell
        cell.backgroundColor = .vanillaWhite
        cell.viewCell.backgroundColor = .lightGray
        
        cell.labelCell.text = abouts[indexPath.section]
  
        return cell
    }
}


class AboutCell: UITableViewCell {
    
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var viewCell: UIView!
}

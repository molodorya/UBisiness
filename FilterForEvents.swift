//
//  FilterForEvents.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 16.08.2021.
//

import UIKit

class FilterForEvent: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clear: UIButton!
    @IBOutlet weak var apply: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        bounceScroll(scrollView: scrollView)

        navigationController?.navigationBar.barTintColor = .vanillaWhite
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.shadowImage = UIImage()

        clear.layer.borderWidth = 2
        clear.layer.borderColor = UIColor.black.cgColor
        clear.layer.cornerRadius = 5

        apply.layer.cornerRadius = 5

        tableView.backgroundColor = .vanillaWhite

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)

        let alertController = UIAlertController(title: "В разработке", message: nil, preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
    }
    
  
    
    
    @objc func viewTapped() {
        print("f")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.revealViewController()?.gestureEnabled = false
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            self.revealViewController()?.gestureEnabled = true
        }
}



extension FilterForEvent: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterForEventCell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.backgroundColor = .vanillaWhite
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "теги"
        case 1:
            cell.textLabel?.text = "геолокация"
        default:
            break
        }
        
        return cell
    }
    
    
    // Единственное
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if (indexPath.row == 0){
            print("1")
            return true
        } else if (indexPath.row == 1){
            print("2")
            return true
        }
        return false
    }
    
    
   public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("s \(indexPath.row)")
    }
    
    public func tableView(tableView: UITableViewDelegate, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("d \(indexPath.row)")

      }
}

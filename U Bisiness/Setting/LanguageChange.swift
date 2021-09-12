//
//  LanguageChange.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 29.08.2021.
//

import UIKit

class LanguageChange: UITableViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .vanillaWhite
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        if SideMenuViewController.languageApplication == "en" {
            navigationItem.title = "Interface language"
        } else if SideMenuViewController.languageApplication == "de"{
            navigationItem.title = "Interface-Sprache"
        } else if SideMenuViewController.languageApplication == "ru" {
            navigationItem.title = "Язык интерфейса"
        }
        
      
    }
    
    
    let language = ["English", "Русский", "Deutsch"]

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return language.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            UserDefaults.standard.set(["en-GB"], forKey: "AppleLanguages")
            UserDefaults.standard.setValue("en", forKey: "languageCustom")
            UserDefaults.standard.synchronize()
            navigationItem.title = "Interface language"
        case 1:
            UserDefaults.standard.set(["ru"], forKey: "AppleLanguages")
            UserDefaults.standard.setValue("ru", forKey: "languageCustom")
            UserDefaults.standard.synchronize()
            navigationItem.title = "Язык интерфейса"
        case 2:
            UserDefaults.standard.set(["de"], forKey: "AppleLanguages")
            UserDefaults.standard.setValue("de", forKey: "languageCustom")
            UserDefaults.standard.synchronize()
            navigationItem.title = "Interface-Sprache"
        default:
            break
        }
        
        let alertController = UIAlertController(title: "Смена языка (beta)", message: "Язык изменится после перезагрузки приложения", preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell", for: indexPath)
        
        cell.backgroundColor = .vanillaWhite
        
        cell.textLabel?.text = language[indexPath.row]
     

        return cell
    }
}

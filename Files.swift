//
//  Files.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 24.06.2021.
//

import UIKit

class Files: UIViewController {
    
    static let nameTableCell: String = "filesTable"
    static let nameCollectionCell: String = "filesCollection"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


extension Files: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Files.nameTableCell, for: indexPath)
        
        
        switch indexPath.section {
        case 0: cell.textLabel?.text = "document"
        case 1: cell.textLabel?.text = "picture"
        case 2: cell.textLabel?.text = "video"
        case 3: cell.textLabel?.text = "audio"
            
        default:
            break
        }
        return  cell
    }
}



extension Files: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Files.nameCollectionCell, for: indexPath) as! settingCollectionViewFiles
        
   
        cell.label1.text = "Документы"
        cell.label2.text = "DOC - PDF"
        
        return cell
    }
    
    
}



class settingCollectionViewFiles: UICollectionViewCell {
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    
    
    
    
    
}

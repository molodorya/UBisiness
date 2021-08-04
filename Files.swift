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

    // Navigation Bar
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    
    // Views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UIView!
    
    // Constraints
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    // Content
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var buttonLast: UIButton!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    //
    func settingButtonLast() {
        buttonLast.backgroundColor = .vanillaWhiteContrast
        buttonLast.setTitleColor(.black, for: .normal)
        buttonLast.layer.cornerRadius = 5
    }
    
    func settingButtonFavorite() {
        buttonFavorite.setTitleColor(.lightGray, for: .normal)
        buttonFavorite.backgroundColor = .clear
        buttonFavorite.layer.cornerRadius = 5
    }
    
    @IBAction func actionLast(_ sender: UIButton) {
        buttonFavorite.backgroundColor = .clear
        buttonFavorite.setTitleColor(.lightGray, for: .normal)
        
        buttonLast.backgroundColor = .vanillaWhiteContrast
        buttonLast.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func actionFavorite(_ sender: UIButton) {
        buttonLast.backgroundColor = .clear
        buttonLast.setTitleColor(.lightGray, for: .normal)
        
        buttonFavorite.backgroundColor = .vanillaWhiteContrast
        buttonFavorite.setTitleColor(.black, for: .normal)
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        headerView.backgroundColor = .vanillaWhite
        settingButtonLast()
        settingButtonFavorite()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .vanillaWhite
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .vanillaWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        leftAction(.init())
    }
    
    @IBAction func leftAction(_ sender: UIBarButtonItem) {
        leftBarButton.target = revealViewController()
        leftBarButton.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tableView.reloadData()
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

// Extension CollectionView
extension Files: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    
  

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scrollCollection", for: indexPath) as! CollectionCellFiles
        cell.layer.cornerRadius = 10
            
        
        switch indexPath.row {
        case 0:
            cell.titleView.text = "Документы"
            cell.promptView.text = "DOC - PDF"
            cell.backgroundColor = UIColor.init(red: 149/255, green: 209/255, blue: 187/255, alpha: 0.2)
        case 1:
            cell.titleView.text = "Фото"
            cell.promptView.text = "JPEG - PNG"
            cell.backgroundColor = UIColor.init(red: 255/255, green: 197/255, blue: 158/255, alpha: 0.2)
        case 2:
            cell.titleView.text = "Видео"
            cell.promptView.text = "MP4"
            cell.backgroundColor = UIColor.init(red: 255/255, green: 152/255, blue: 155/255, alpha: 0.2)
        default:
            break
        }

        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("d")
    }
}

// Extension TableView
extension Files: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "filesTable", for: indexPath) as! FilesTable
        cell.imageFiles.layer.cornerRadius = 5
        cell.contentImage.layer.cornerRadius = 5
        cell.backgroundColor = .vanillaWhite
        cell.imageFiles.image = UIImage.init(systemName: "doc")
        

        
        switch indexPath.section {
        case 0:
            cell.titleFiles.text = "document.pdf \(indexPath.row)"
            cell.weightFiles.text = "256 kb"
            cell.contentImage.backgroundColor = UIColor.init(red: 149/255, green: 209/255, blue: 187/255, alpha: 0.2)
        case 1:
            cell.titleFiles.text = "picture.jpeg"
            cell.weightFiles.text = "256 kb"
            cell.contentImage.backgroundColor = UIColor.init(red: 255/255, green: 197/255, blue: 158/255, alpha: 0.2)
        case 2:
            cell.titleFiles.text = "video.mp4"
            cell.weightFiles.text = "256 kb"
            cell.contentImage.backgroundColor = UIColor.init(red: 222/255, green: 240/255, blue: 251/255, alpha: 0.5)
        case 3:
            cell.titleFiles.text = "audio.pm3"
            cell.weightFiles.text = "256 kb"
            cell.contentImage.backgroundColor = .darkGray
            cell.contentImage.backgroundColor = UIColor.init(red: 247/255, green: 232/255, blue: 240/255, alpha: 0.5)
        default:
            break
        }
        return  cell
    }
}



// Class For TableView and CollectionView
class FilesTable: UITableViewCell {
    @IBOutlet weak var imageFiles: UIImageView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var titleFiles: UILabel!
    @IBOutlet weak var weightFiles: UILabel!
}


class CollectionCellFiles: UICollectionViewCell {
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var promptView: UILabel!
}

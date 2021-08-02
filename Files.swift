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

    @IBOutlet weak var scrollView: UIScrollView?
    @IBOutlet weak var contentView: UIView?
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var collectionView: UICollectionView?
    
    @IBOutlet weak var viewButton: UIView?
    @IBOutlet weak var buttonLast: UIButton?
    @IBOutlet weak var buttonFavorite: UIButton?
    
    
    @IBOutlet weak var leftBarButton: UIBarButtonItem!
    
    
    func settingButtonLast() {
        buttonLast?.backgroundColor = .vanillaWhiteContrast
        buttonLast?.setTitleColor(.black, for: .normal)
        
        buttonLast?.layer.cornerRadius = 5
    }
    
    func settingButtonFavorite() {
        buttonFavorite?.setTitleColor(.lightGray, for: .normal)
        buttonFavorite?.backgroundColor = .clear
        
        buttonFavorite?.layer.cornerRadius = 5
    }
    
    
    @IBAction func actionLast(_ sender: UIButton) {
        buttonFavorite?.backgroundColor = .clear
        buttonFavorite?.setTitleColor(.lightGray, for: .normal)
        
        buttonLast?.backgroundColor = .vanillaWhiteContrast
        buttonLast?.setTitleColor(.black, for: .normal)
        
        
        
    }
    
    @IBAction func actionFavorite(_ sender: UIButton) {
        buttonLast?.backgroundColor = .clear
        buttonLast?.setTitleColor(.lightGray, for: .normal)
        
        buttonFavorite?.backgroundColor = .vanillaWhiteContrast
        buttonFavorite?.setTitleColor(.black, for: .normal)
        
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftBarButton.image = linesImage
        
        
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
       
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
        settingButtonLast()
        settingButtonFavorite()
        
        viewButton?.backgroundColor = .vanillaWhite
     

        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = .vanillaWhite
        tableView?.separatorStyle = .none
        tableView?.showsVerticalScrollIndicator = false
       
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .vanillaWhite
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 90)
    }
    
    
    
 
}


extension Files: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Files.nameTableCell, for: indexPath) as! TableCellFiles
        cell.backgroundColor = .vanillaWhite
        
        switch indexPath.section {
        case 0:
            cell.titleFiles.text = "document.pdf"
            cell.weightFiles.text = "256 kb"
            cell.imageFiles.backgroundColor = .green
            cell.contentImage.image = UIImage.init(named: "document")
        case 1:
            cell.titleFiles.text = "picture.jpeg"
            cell.weightFiles.text = "256 kb"
            cell.imageFiles.backgroundColor = .systemYellow
        case 2:
            cell.titleFiles.text = "video.mp4"
            cell.weightFiles.text = "256 kb"
            cell.imageFiles.backgroundColor = .cyan
        case 3:
            cell.titleFiles.text = "audio.pm3"
            cell.weightFiles.text = "256 kb"
            cell.imageFiles.backgroundColor = .systemPink
        default:
            break
        }
        return  cell
    }
}



extension Files: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Files.nameCollectionCell, for: indexPath) as! CollectionCellFiles
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        
        
        switch indexPath.row {
        case 0:
            cell.backgroundColor = .green
            cell.titleView.text = "Документы"
            cell.promptView.text = "DOC - PDF"
        case 1:
            cell.backgroundColor = .cyan
            cell.titleView.text = "Фото"
            cell.promptView.text = "JPEG - PNG"
        default:
            break
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            print("1")
        case 1:
            print("2")
        default:
            break
        }
    }
}


class TableCellFiles: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIView!
    @IBOutlet weak var imageFiles: UIImageView!
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var titleFiles: UILabel!
    @IBOutlet weak var weightFiles: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.layer.cornerRadius = 5
        imageFiles.layer.cornerRadius = 5
    }
    
    
    
    
}


class CollectionCellFiles: UICollectionViewCell {
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var promptView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        titleView.text = "Label"
        promptView.text = "Prompt"
        
       print("collection view is load")
    }
    
}

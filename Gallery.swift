//
//  Gallery.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 15.07.2021.
//

import UIKit

class Gallery: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let cellName: String = "galleryCell"
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var leftBar: UIBarButtonItem!
    @IBOutlet weak var rightBar: UIBarButtonItem!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .vanillaWhite
      
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .vanillaWhite
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 30, bottom: 50, right: 30)
        
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerCell")
        
        leftAction(.init())
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear

        
        let alertController = UIAlertController(title: "В разработке", message: nil, preferredStyle:UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func leftAction(_ sender: UIBarButtonItem) {
        leftBar.target = revealViewController()
        leftBar.action = #selector(revealViewController()?.revealSideMenu)
    }
    
    
    @IBAction func rightAction(_ sender: UIBarButtonItem) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerCell", for: indexPath) as? SectionHeader {

            sectionHeader.headerLabel.text = "Фотопленка"
            
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
   
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as! GalleryCell
        
//        cell.photo.image = UIImage.init(named: "crimea")

        
        return cell
    }
    
    
    
}

class SectionHeader: UICollectionReusableView {
    
    var headerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.sizeToFit()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(headerLabel)
        
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: -20).isActive = true
        headerLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




class GalleryCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        photo.layer.cornerRadius = 5
        photo.contentMode = .scaleAspectFill
//        photo.image = UIImage.init(named: "crimea")
        
        
        
    }
}

//
//  temporaryNavigation.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 23.07.2021.
//

import UIKit

class NavigationCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
}

class TemporaryNavigation: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.showsHorizontalScrollIndicator = false
    }
}

extension TemporaryNavigation: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(identifier: "registationController")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 1:
            let vc = storyboard?.instantiateViewController(identifier: "eventNavigation")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 2:
            let vc = storyboard?.instantiateViewController(identifier: "newsNavigation")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 3:
            let vc = storyboard?.instantiateViewController(identifier: "menuNavigation")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 4:
            let vc = storyboard?.instantiateViewController(identifier: "homeNavigation")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 5:
            let vc = storyboard?.instantiateViewController(identifier: "settingNavigation")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 6:
            let vc = storyboard?.instantiateViewController(identifier: "settingLibrary")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 7:
            let vc = storyboard?.instantiateViewController(identifier: "settingGallery")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 8:
            let vc = storyboard?.instantiateViewController(identifier: "recoveryPassword")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        case 9:
            let vc = storyboard?.instantiateViewController(identifier: "shareNavigation")
            vc?.modalPresentationStyle = .automatic //or .overFullScreen for transparency
            self.present(vc ?? Home(), animated: true, completion: nil)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "navigation", for: indexPath) as! NavigationCell
        
        cell.layer.cornerRadius = 10
        
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Экраны регистрации"
            cell.titleLabel.backgroundColor = .systemGreen
        case 1:
            cell.titleLabel.text = "Страницы"
            cell.titleLabel.backgroundColor = .systemGreen
        case 2:
            cell.titleLabel.text = "Новости"
            cell.titleLabel.backgroundColor = .systemRed
        case 3:
            cell.titleLabel.text = "Пользователькие настройки"
            cell.titleLabel.backgroundColor = .systemRed
        case 4:
            cell.titleLabel.text = "Главный экран"
            cell.titleLabel.backgroundColor = .systemRed
        case 5:
            cell.titleLabel.text = "Настройки"
            cell.titleLabel.backgroundColor = .systemRed
        case 6:
            cell.titleLabel.text = "Библиотека"
            cell.titleLabel.backgroundColor = .systemRed
        case 7:
            cell.titleLabel.text = "Галерея"
            cell.titleLabel.backgroundColor = .systemRed
        case 8:
            cell.titleLabel.text = "Сменить пароль"
            cell.titleLabel.backgroundColor = .systemRed
        case 9:
            cell.titleLabel.text = "Визитки"
            cell.titleLabel.backgroundColor = .systemRed
        default:
            break
        }

        
        return cell
    }
}

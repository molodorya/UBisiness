//
//  Home.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 07.05.2021.
//
    
import UIKit
import Foundation
extension UIColor{
    class func homeColorNav() -> UIColor {
        return UIColor.init(red: 251/255, green: 229/255, blue: 212/255, alpha: 1)
    }
}
class Home: UIViewController {

   // CollectionViews
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewNews: UICollectionView!
    
    
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var user: UIBarButtonItem!
    @IBOutlet weak var sideMenuOutlet: UIBarButtonItem!
    @IBOutlet weak var textEvent: UILabel!
    @IBOutlet weak var buttonEvent: UIButton!
    
    
    
    @IBOutlet weak var one: UIView!
    @IBOutlet weak var two: UIView!
    @IBOutlet weak var three: UIView!
    @IBOutlet weak var four: UIView!
    @IBOutlet weak var five: UIView!
    
   
    @IBOutlet weak var oneNews: UIView!
    @IBOutlet weak var twoNews: UIView!
    @IBOutlet weak var threeNews: UIView!
    @IBOutlet weak var fourNews: UIView!
    @IBOutlet weak var fiveNews: UIView!
    
    let colorHomeNav = UIColor.init(red: 251/255, green: 229/255, blue: 212/255, alpha: 1)
    let statusAuth = UserDefaults.standard.bool(forKey: "auth")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "accessToken") == nil {
            let vc = storyboard?.instantiateViewController(identifier: "Welcome")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
        }
        
        collectionView.tag = 1
        collectionViewNews.tag = 2
 
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
        scrollView.backgroundColor = colorHomeNav
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .vanillaWhite
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionViewNews.delegate = self
        collectionViewNews.dataSource = self
        collectionViewNews.backgroundColor = .vanillaWhite
        collectionViewNews.showsHorizontalScrollIndicator = false
      
        
        sideMenuOutlet.image = linesImage
        
       
        
        navigationController?.navigationBar.barTintColor = colorHomeNav
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.shadowImage = UIImage()
        
        sideMenu(.init())
        
        buttonEvent.layer.cornerRadius = 5
        buttonEvent.backgroundColor = .clear
        buttonEvent.layer.borderWidth = 2
        buttonEvent.layer.borderColor = UIColor.black.cgColor
        
        settingProgressBar()
     
    }
    
    let testVC = MainViewController()
    
    
  
    @IBAction func sideMenu(_ sender: UIBarButtonItem) {
        sideMenuOutlet.target = revealViewController()
        sideMenuOutlet.action = #selector(revealViewController()?.revealSideMenu)
    }
  

    
    
    @IBAction func actionUser(_ sender: UIBarButtonItem) {
        print("user")
    }
    
  
    
    
    @IBAction func actionEvent(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "navEvent")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func pageAction(_ sender: UIPageControl) {
        self.collectionView.scrollToItem(at: IndexPath(row: sender.currentPage, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    // Preset ProgressBar
    private func settingProgressBar() {
        one.backgroundColor = .black
        one.layer.cornerRadius = 4
        
        one.rotate(radians: -165.83)
        one.clipsToBounds = true

        two.rotate(radians: -165.83)
        two.layer.cornerRadius = 4

        three.rotate(radians: -165.83)
        three.layer.cornerRadius = 4

        four.rotate(radians: -165.83)
        four.layer.cornerRadius = 4
        
        five.rotate(radians: -165.83)
        five.layer.cornerRadius = 4
        
        oneNews.backgroundColor = .black
        oneNews.layer.cornerRadius = 4
        
        oneNews.rotate(radians: -165.83)
        oneNews.clipsToBounds = true

        twoNews.rotate(radians: -165.83)
        twoNews.layer.cornerRadius = 4

        threeNews.rotate(radians: -165.83)
        threeNews.layer.cornerRadius = 4

        fourNews.rotate(radians: -165.83)
        fourNews.layer.cornerRadius = 4
        
        fiveNews.rotate(radians: -165.83)
        fiveNews.layer.cornerRadius = 4
    }
    
    
    let numberOfCells = 9
    let kCellHeight : CGFloat = 250
    let kLineSpacing : CGFloat = 15
    let kInset: CGFloat = 10
  
}



extension Home: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return 5
        } else if collectionViewNews.tag == 2 {
            return 5
        } else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
            cell.imageCollection.image = UIImage.init(named: "crimea")
            return cell
            
        } else if collectionView.tag == 2 {
            let newsCell = collectionViewNews.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath)
            return newsCell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if self.collectionView.indexPathForItem(at: visiblePoint) != nil {
        }
        
        if collectionView.tag == 1 {
            let witdh = collectionView.frame.width - (collectionView.contentInset.left * 2)
            let index = collectionView.contentOffset.x / witdh * 3.2
            let nowRoundedIndex = Int(round(index))
            switch nowRoundedIndex {
            case 0:
                one.backgroundColor = .black
                two.backgroundColor = .lightGray
                three.backgroundColor = .lightGray
                four.backgroundColor = .lightGray
                five.backgroundColor = .lightGray
            case 1:
                one.backgroundColor = .lightGray
                two.backgroundColor = .black
                three.backgroundColor = .lightGray
                four.backgroundColor = .lightGray
                five.backgroundColor = .lightGray
            case 2:
                one.backgroundColor = .lightGray
                two.backgroundColor = .lightGray
                three.backgroundColor = .black
                four.backgroundColor = .lightGray
                five.backgroundColor = .lightGray
            case 3:
                one.backgroundColor = .lightGray
                two.backgroundColor = .lightGray
                three.backgroundColor = .lightGray
                four.backgroundColor = .black
                five.backgroundColor = .lightGray
            case 4:
                one.backgroundColor = .lightGray
                two.backgroundColor = .lightGray
                three.backgroundColor = .lightGray
                four.backgroundColor = .lightGray
                five.backgroundColor = .black
            default:
              break
            }
        }
        
        if collectionViewNews.tag == 2 {
            let witdh = collectionViewNews.frame.width - (collectionViewNews.contentInset.left * 2)
            let index = collectionViewNews.contentOffset.x / witdh * 3.2
            let nowRoundedIndex = Int(round(index))
            switch nowRoundedIndex {
            case 0:
                oneNews.backgroundColor = .black
                twoNews.backgroundColor = .lightGray
                threeNews.backgroundColor = .lightGray
                fourNews.backgroundColor = .lightGray
                fiveNews.backgroundColor = .lightGray
            case 1:
                oneNews.backgroundColor = .lightGray
                twoNews.backgroundColor = .black
                threeNews.backgroundColor = .lightGray
                fourNews.backgroundColor = .lightGray
                fiveNews.backgroundColor = .lightGray
            case 2:
                oneNews.backgroundColor = .lightGray
                twoNews.backgroundColor = .lightGray
                threeNews.backgroundColor = .black
                fourNews.backgroundColor = .lightGray
                fiveNews.backgroundColor = .lightGray
            case 3:
                oneNews.backgroundColor = .lightGray
                twoNews.backgroundColor = .lightGray
                threeNews.backgroundColor = .lightGray
                fourNews.backgroundColor = .black
                fiveNews.backgroundColor = .lightGray
            case 4:
                oneNews.backgroundColor = .lightGray
                twoNews.backgroundColor = .lightGray
                threeNews.backgroundColor = .lightGray
                fourNews.backgroundColor = .lightGray
                fiveNews.backgroundColor = .black
            default:
              break
            }

        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1 {
        } else if collectionView.tag == 2 {
            return CGSize(width: 170, height: 300)
        } else {
            
        }
        
        return CGSize(width: 0, height: 0)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
}


extension Home {
    func checkToken(url: String) {
        
        var request = URLRequest.init(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "Error Token")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            let nsHTTPResponse = response as? HTTPURLResponse
            let statusCode = nsHTTPResponse?.statusCode ?? 0
            
            
            if statusCode == 200 {
              
                
            } else if statusCode == 401 {
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Ошибка авторизации", message: nil, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Перезайти", style: .cancel, handler: { UIAlertAction in
                        
                    }))
                   
                }
            }
        })
        
        dataTask.resume()
    }
}

   








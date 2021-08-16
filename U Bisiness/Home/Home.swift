//
//  Home.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 07.05.2021.
//
    
import UIKit
import Foundation

extension UIColor {
    class func homeColorNav() -> UIColor {
        return UIColor.init(red: 251/255, green: 229/255, blue: 212/255, alpha: 1)
    }
}

class Home: UIViewController {

    @IBOutlet weak var collectionViewOffer: UICollectionView!

    // Views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var user: UIBarButtonItem!
    @IBOutlet weak var sideMenuOutlet: UIBarButtonItem!
    
    //Event
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleEvent: UILabel!
    @IBOutlet weak var dateEvent: UILabel!
    
    //News
    @IBOutlet weak var collectionViewNews: UICollectionView!
    
    
    // Content
    @IBOutlet weak var textEvent: UILabel!
    @IBOutlet weak var buttonEvent: UIButton!
    @IBOutlet weak var textOffer: UILabel!
    
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
    
    @IBOutlet weak var oneOffer: UIView!
    @IBOutlet weak var twoOffer: UIView!
    @IBOutlet weak var threeOffer: UIView!
    @IBOutlet weak var fourOffer: UIView!
    @IBOutlet weak var fiveOffer: UIView!
    
    let colorHomeNav = UIColor.init(red: 251/255, green: 229/255, blue: 212/255, alpha: 1)
    let statusAuth = UserDefaults.standard.bool(forKey: "auth")
    
    static var events: [EventStruct]?
    static var news: [NewsStruct]?
    static var offers: [OfferStruct]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.string(forKey: "Auth") != nil) == false {
            let vc = storyboard?.instantiateViewController(identifier: "Welcome")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
            
            
            
            // Можно ничего не загружать пока диссмис не будет
            
        }
        
        eventFetch(url: "https://ubusiness-ithub.ru/api/fetchevents")
        newsFetch(url: "https://ubusiness-ithub.ru/api/fetchnewslist")
        offerFetch(url: "https://ubusiness-ithub.ru/api/fetchOffers")

        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        scrollView.backgroundColor = colorHomeNav
        scrollView.bounces = true
        scrollView.showsVerticalScrollIndicator = false
        
        dateEvent.textColor = UIColor.init(red: 255/255, green: 152/255, blue: 155/255, alpha: 1)
        
        collectionView.tag = 1
        collectionViewNews.tag = 2
        collectionViewOffer.tag = 3
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .vanillaWhite
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionViewNews.delegate = self
        collectionViewNews.dataSource = self
        collectionViewNews.backgroundColor = .vanillaWhite
        collectionViewNews.showsHorizontalScrollIndicator = false
        
        collectionViewOffer.delegate = self
        collectionViewOffer.dataSource = self
        collectionViewOffer.backgroundColor = .vanillaWhite
        collectionViewOffer.showsHorizontalScrollIndicator = false
        collectionViewOffer.backgroundColor = .vanillaWhite
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
        
        print(Token.idUser)

    }
    
    @IBAction func sideMenu(_ sender: UIBarButtonItem) {
        sideMenuOutlet.target = revealViewController()
        sideMenuOutlet.action = #selector(revealViewController()?.revealSideMenu)
    }
  
    @IBAction func actionUser(_ sender: UIBarButtonItem) {
        print("user")
    }
    
    @IBAction func actionEvent(_ sender: UIButton) {
        let viewController = storyboard!.instantiateViewController(withIdentifier: "navigationEvents")
        present(viewController, animated: true, completion: nil)
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
        
        // News page
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
        
        // Offer page
        oneOffer.backgroundColor = .black
        oneOffer.layer.cornerRadius = 4
        
        oneOffer.rotate(radians: -165.83)
        oneOffer.clipsToBounds = true

        twoOffer.rotate(radians: -165.83)
        twoOffer.layer.cornerRadius = 4

        threeOffer.rotate(radians: -165.83)
        threeOffer.layer.cornerRadius = 4

        fourOffer.rotate(radians: -165.83)
        fourOffer.layer.cornerRadius = 4
        
        fiveOffer.rotate(radians: -165.83)
        fiveOffer.layer.cornerRadius = 4
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
    // правильная логика
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        print("fsf")
        }
    
    // неправильная логика
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {

        if collectionView.tag == 1 {
           
            
            return true
        } else {
            return false
        }
       
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath) as! EventCell
            
            if let title = Home.events?[0] {
                titleEvent.text = title.title
                dateEvent.text = title.date
            }
            
            switch indexPath.row {
            case 1...3:
                cell.imageCollection.backgroundColor = UIColor.systemIndigo
            case 4:
                cell.imageCollection.image = UIImage.init(named: "eventMore")
            default:
                break
            }
            
           
 
            return cell
            
        } else if collectionView.tag == 2 {
            let newsCell = collectionViewNews.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as! CellNews
            
            if let title = Home.news?[indexPath.row] {
                newsCell.title.text = title.title
            }
            
            if let date = Home.news?[indexPath.row] {
                newsCell.date.text = date.date
            }
            
            if let banner = Home.news?[indexPath.row] {
                
            }
            
            if let id = Home.news?[indexPath.row] {
                print("newsId \(id.id)")
            }
            
            switch indexPath.section {
            case 1...3:
                newsCell.photo.backgroundColor = UIColor.systemIndigo
            case 4:
                newsCell.photo.image = UIImage.init(named: "eventNews")
            default:
                break
            }
            
            
        
            
            return newsCell
            
        } else if collectionViewOffer.tag == 3 {
            let offerCell = collectionViewOffer.dequeueReusableCell(withReuseIdentifier: "offerCell", for: indexPath) as! CellOffer
            offerCell.layer.cornerRadius = 5
            
            if let title = Home.offers?[indexPath.row] {
                offerCell.centerLabel.text = title.title
            }
            
            switch indexPath.section {
            case 1...3:
                offerCell.photo.backgroundColor = UIColor.systemIndigo
            case 4:
                offerCell.photo.image = UIImage.init(named: "eventOffer")
            default:
                break
            }
            
            return offerCell
            
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
        
        if collectionViewOffer.tag == 3 {
            let witdh = collectionViewOffer.frame.width - (collectionViewOffer.contentInset.left * 2)
            let index = collectionViewOffer.contentOffset.x / witdh * 3.2
            let nowRoundedIndex = Int(round(index))
            switch nowRoundedIndex {
            case 0:
                oneOffer.backgroundColor = .black
                twoOffer.backgroundColor = .lightGray
                threeOffer.backgroundColor = .lightGray
                fourOffer.backgroundColor = .lightGray
                fiveOffer.backgroundColor = .lightGray
            case 1:
                oneOffer.backgroundColor = .lightGray
                twoOffer.backgroundColor = .black
                threeOffer.backgroundColor = .lightGray
                fourOffer.backgroundColor = .lightGray
                fiveOffer.backgroundColor = .lightGray
            case 2:
                oneOffer.backgroundColor = .lightGray
                twoOffer.backgroundColor = .lightGray
                threeOffer.backgroundColor = .black
                fourOffer.backgroundColor = .lightGray
                fiveOffer.backgroundColor = .lightGray
            case 3:
                oneOffer.backgroundColor = .lightGray
                twoOffer.backgroundColor = .lightGray
                threeOffer.backgroundColor = .lightGray
                fourOffer.backgroundColor = .black
                fiveOffer.backgroundColor = .lightGray
            case 4:
                oneOffer.backgroundColor = .lightGray
                twoOffer.backgroundColor = .lightGray
                threeOffer.backgroundColor = .lightGray
                fourOffer.backgroundColor = .lightGray
                fiveOffer.backgroundColor = .black
            default:
              break
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 1 {
            return CGSize(width: 170, height: 250)
        } else if collectionViewNews.tag == 2 {
            return CGSize(width: 170, height: 300)
        } else if collectionViewOffer.tag == 3 {
            return CGSize(width: 368, height: 200)
        } else {
            return CGSize()
        }
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

   








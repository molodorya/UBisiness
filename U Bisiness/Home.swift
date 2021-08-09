//
//  Home.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 07.05.2021.
//
    
import UIKit
import Foundation

class Home: UIViewController {

   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sideMenuOutlet: UIBarButtonItem!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    @IBOutlet weak var user: UIBarButtonItem!
    
    let statusAuth = UserDefaults.standard.bool(forKey: "auth")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "accessToken") == nil {
            let vc = storyboard?.instantiateViewController(identifier: "Welcome")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
        }
 
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .vanillaWhite
        collectionView.showsHorizontalScrollIndicator = false
      
        
        sideMenuOutlet.image = linesImage
        
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
      
        pageControl.numberOfPages = 10
    
        
        sideMenu(.init())
        
       
     
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
    
    
    let numberOfCells = 9
    let kCellHeight : CGFloat = 250
    let kLineSpacing : CGFloat = 15
    let kInset: CGFloat = 10
  
}



extension Home: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "events", for: indexPath) as! collectionViewCell
        cell.imageCollection.image = UIImage.init(named: "crimea")
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
            self.pageControl.currentPage = visibleIndexPath.row
        }
    }
    
    
    
}

extension Home: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 90)
    }
    
   
}




class collectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageCollection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollection.layer.cornerRadius = 15
        imageCollection.image = UIImage.init(named: "crimea")
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

   








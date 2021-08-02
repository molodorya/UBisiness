//
//  Home.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 07.05.2021.
//
    
import UIKit
import Foundation

class Home: UIViewController, UIViewControllerTransitioningDelegate {

    private var sideMenuViewController: SideMenuViewController!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var sideMenuOutlet: UIBarButtonItem!
    
    @IBOutlet weak var user: UIBarButtonItem!
    
    let statusAuth = UserDefaults.standard.bool(forKey: "auth")
  
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let viewControllers = navigationController?.viewControllers,
        let index = viewControllers.firstIndex(of: self) else { return }
        navigationController?.viewControllers.remove(at: index)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.string(forKey: "accessToken") == nil {
            let vc = storyboard?.instantiateViewController(identifier: "Welcome")
            vc?.modalPresentationStyle = .fullScreen
            self.present(vc!, animated: true, completion: nil)
        }
        
        
        
        
        
        
        checkToken(url: "https://ubusiness-ithub.ru/api/fetchBusinessCard")
        colorVanilla(view: view, scrollView: scrollView, contentView: contentView)
        
        
        
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9058110118, blue: 0.8383547664, alpha: 1)

        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        sideMenuOutlet.image = linesImage
        
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
            navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
      
       
    
        
        sideMenu(.init())
        
       
     
    }
    
    let testVC = MainViewController()
    
    
  
    @IBAction func sideMenu(_ sender: UIBarButtonItem) {
        sideMenuOutlet.target = revealViewController()
        sideMenuOutlet.action = #selector(revealViewController()?.revealSideMenu)
        
        
    }
  

    
    
    @IBAction func actionUser(_ sender: UIBarButtonItem) {
//        let vc = storyboard!.instantiateViewController(withIdentifier: "navUser")
        
    
        
    }
    
  
    
    
    @IBAction func actionEvent(_ sender: UIButton) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "navEvent")
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
  
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
   








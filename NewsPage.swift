//
//  NewsPage.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 24.06.2021.
//

import UIKit

class NewsPage: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var hiddenContenView: UIView!
    
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFetchId()

        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.setBackgroundImage(UIImage(), for: .default)
        navigationBar?.shadowImage = UIImage()
        navigationBar?.backgroundColor = UIColor.clear
        
        colorVanilla(view: view, scrollView: scrollView, contentView: hiddenContenView)
        
        profileView.backgroundColor = .vanillaWhite
        container.backgroundColor = .vanillaWhite
        
        scrollView.contentInsetAdjustmentBehavior = .never
      
        label.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 1.6)
        label.backgroundColor = .vanillaWhite
    }
    
    @IBAction func leftAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rightAction(_ sender: UIBarButtonItem) {
        
    }
}

struct newsPage: Codable {
    var id: Int?
    var title: String?
    var date: String?
    var text: String
    var banner: String?
    var type: String?
}

extension NewsPage {
    func newsFetchId() {
        
        let idNewsTouch = UserDefaults.standard.integer(forKey: "idNewsClick")
        
        var request = URLRequest.init(url: NSURL(string: "https://ubusiness-ithub.ru/api/opennews?id=\(idNewsTouch)")! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try? JSONDecoder().decode(newsPage.self, from: data)
                    DispatchQueue.main.async {
                        centerLabel.text = json?.title
                        bottomLabel.text = json?.date
                        profileImageView.downloaded(from: "https://ubusiness-ithub.ru/news/\(json?.banner ?? "")")
                        label.text = json?.text
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}

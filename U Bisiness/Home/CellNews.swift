//
//  CellNews.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 11.08.2021.
//

import UIKit

class CellNews: UICollectionViewCell {
    
 
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = 5
        button.underLineButton(text: "Подробнее >")
        cellView.backgroundColor = .vanillaWhite
    }

    
    @IBAction func buttonMoreDetails(_ sender: UIButton) {
        print("more details")
        
    }
    
    
}

struct NewsStruct: Codable {
    var id: Int?
    var title: String?
    var date: String?
    var banner: String?
    var type: String?
}

typealias NewsType = [NewsStruct]



extension Home {
    func newsFetch(url: String) {
        var request = URLRequest.init(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { [self] (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(NewsType.self, from: data)
                    Home.news = json
                    DispatchQueue.main.async {
                        collectionViewNews.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}


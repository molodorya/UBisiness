//
//  CellEvent.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 11.08.2021.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCollection: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollection.layer.cornerRadius = 15
    }
}




struct EventStruct: Codable {
    var id: Int?
    var title: String?
    var date: String?
    var banner: String?
    var category: String?
    var users: [Int]?
    var type: String?
}

typealias eventType = [EventStruct]

extension Home {
    func eventFetch(url: String) {
        var request = URLRequest.init(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(eventType.self, from: data)
                    Home.events = json
                   
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
            
        })
        task.resume()
    }
}




/*
struct EventStruct: Codable {
    var id: Int?
    var title, date, text: String?
    var users: [Int]?
    var banner, category, type: String?
    
    enum CodingKeys: String, CodingKey {
           case id
           case title
           case date
           case text
           case users
           case banner
           case category
           case type
       }
}

typealias EventType = [EventStruct]

extension Home {
    func eventFetch(url: String) {
        var request = URLRequest.init(url: NSURL(string: url)! as URL)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Token.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config)
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(EventType.self, from: data)
                    Home.events = [json]
                
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}
*/



//
//  OfferCell.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 11.08.2021.
//

import UIKit

class CellOffer: UICollectionViewCell {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}


struct OfferStruct: Codable {
    var id: Int?
    var imgurl: String?
    var title: String?
    var welcomeProtocol: String?
    var timecreation: String?
    var term: String?
    var text: String?
    var idcreator: Int?
    var type: String?
}

typealias offerType = [OfferStruct]


extension Home {
    func offerFetch(url: String) {
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
                    let json = try JSONDecoder().decode(offerType.self, from: data)
                    Home.offers = json
                   
                    DispatchQueue.main.async {
                        collectionViewOffer.reloadData()
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}


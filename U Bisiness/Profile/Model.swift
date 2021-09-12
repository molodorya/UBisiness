//
//  Model.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 20.08.2021.
//
import UIKit
import Foundation

struct OfferFetch: Codable {
    var id: Int?
    var imgurl: String?
    var title: String?
    var `protocol`: String?
    var timecreation: String?
    var term: String?
    var text: String?
    var idcreator: Int?
    var type: String?
}


extension SettingOffer {
    typealias offerType = [OfferFetch]
    
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
                        offersUser = [json]
                       
                        DispatchQueue.main.async {
                            SettingOffer.countCell = json.endIndex
                            print(SettingOffer.countCell)
                            tableView.reloadData()
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
            })
            task.resume()
        }
    
    func offerFetchOld(url: String) {
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
                    offersUser = [json]
                   
                    DispatchQueue.main.async {
                        SettingOffer.countCell = json.endIndex
                        
                        if SettingOffer.countCell == 0 {
                            let alertController = UIAlertController(title: "Просроченных предложений нету", message: nil, preferredStyle:UIAlertController.Style.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                        tableView.reloadData()
                    }
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
    }
}


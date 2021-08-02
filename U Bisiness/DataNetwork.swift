//
//  SettingHeaderBar.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 27.06.2021.
//
import UIKit
import Foundation




class DataNetwork: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
                   
                }
                
            })
            dataTask.resume()
        }
    
//        checkToken(url: "https://ubusiness-ithub.ru/api/fetchBusinessCard")
        
        
    }

}

//
//  AppDelegate.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 02.04.2021.
//

import UIKit

struct Login: Decodable {
    var accessToken: String?
    var id: Int?
    var refreshToken: String
    var role: String?
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    static var nowNetworkConnection = true
    var window: UIWindow?
    
    
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// Сделать ее умней проверять при запуске сначала
        
        
        print("Token \(Token.accessToken)")
        
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { Timer in
            DispatchQueue.main.async {
                let url = URL(string: "https://www.google.com")!
                let request = URLRequest(url: url)

                let task = URLSession.shared.dataTask(with: request) {data, response, error in

                    if error != nil {
                        AppDelegate.nowNetworkConnection = false
                    }
                    else if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            AppDelegate.nowNetworkConnection = true
                        }
                    }
                }
                print("Internet connection: \(AppDelegate.nowNetworkConnection)")
                task.resume()
            }
        }
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//         Вызывается при создании нового сеанса сцены.
        // Используйте этот метод, чтобы выбрать конфигурацию для создания новой сцены.
        
    
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Вызывается, когда пользователь отменяет сеанс сцены.
        // Если какие-либо сеансы были отменены, пока приложение не работало, это будет вызвано вскоре после application: didFinishLaunchingWithOptions.
        // Используйте этот метод, чтобы освободить любые ресурсы, относящиеся к отброшенным сценам, поскольку они не вернутся.
    }
    
    
}




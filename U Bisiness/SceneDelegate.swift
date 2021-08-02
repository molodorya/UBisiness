//
//  SceneDelegate.swift
//  U Bisiness
//
//  Created by Nikita Molodorya on 02.04.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        
        

//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = News()
//        window.makeKeyAndVisible()
//        self.window = window
//
////
//        let viewController = Home()
//        let navViewController = UINavigationController(rootViewController: viewController)
//        window.rootViewController = navViewController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    
        // Вызывается, когда сцена освобождается системой.
        // Это происходит вскоре после того, как сцена переходит в фон или когда ее сеанс отменяется.
        // Освобождаем все ресурсы, связанные с этой сценой, которые можно будет воссоздать при следующем подключении сцены.
        // Сцена может повторно подключиться позже, поскольку ее сеанс не обязательно был отменен (вместо этого см. `Application: didDiscardSceneSessions`).
    }
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Вызывается, когда сцена перешла из неактивного состояния в активное.
        // Используйте этот метод для перезапуска любых задач, которые были приостановлены (или еще не запущены), когда сцена была неактивна.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Вызывается, когда сцена переходит из активного состояния в неактивное.
        // Это может произойти из-за временных перебоев (например, входящий телефонный звонок).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Вызывается при переходе сцены от фона к переднему плану.
        // Используйте этот метод, чтобы отменить изменения, сделанные при входе в фон.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Вызывается при переходе сцены от переднего плана к фону.
        // Используйте этот метод для сохранения данных, освобождения общих ресурсов и хранения достаточной информации о состоянии конкретной сцены
        // чтобы вернуть сцену в ее текущее состояние.
    }
    
    
}


//
//  AppDelegate.swift
//  Japanki
//
//  Created by Hoang Luong on 8/8/20.
//

import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if UserDefaults.standard.bool(forKey: "test") != true {
            UserDefaults.standard.setValue(true, forKey: "test")
            
            let factory = CardFactory()
            let cards = factory.getTestCards()
            
            let testDeck = Deck()
            testDeck.cards.append(objectsIn: cards)
            testDeck.id = UUID().uuidString
            testDeck.name = "Test Deck"
            
            RealmService.shared.write(testDeck)
        }
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(appMovedToForeground),
            name: UIApplication.willEnterForegroundNotification, object: nil)
        
        return true
    }
    
    @objc private func appMovedToForeground() {
        if let copyString = UIPasteboard.general.string {
            //  Returned to app with copied text, ask to create a new card
            print(copyString)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


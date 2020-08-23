//
//  AppDelegate.swift
//  Japanki
//
//  Created by Hoang Luong on 8/8/20.
//

import Firebase
import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
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
        
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
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
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}

}


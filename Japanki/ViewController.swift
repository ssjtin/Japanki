//
//  ViewController.swift
//  Japanki
//
//  Created by Hoang Luong on 8/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    //  MARK: -> Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNotifications()
        let factory = CardFactory()
        factory.getTestCards()
    }
    
    private func setupNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(appMovedToForeground),
            name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    //  MARK: -> Selector functions
    
    @objc private func appMovedToForeground() {
        if let copyString = UIPasteboard.general.string {
            //  Returned to app with copied text, ask to create a new card
            print(copyString)
        }
    }
    
}


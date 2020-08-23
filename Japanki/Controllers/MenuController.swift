//
//  ViewController.swift
//  Japanki
//
//  Created by Hoang Luong on 8/8/20.
//

import UIKit

class MenuController: UIViewController {
    
    //  MARK: -> Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        RealmService.shared.clear()
        
        if let user = FirebaseService.shared.checkCurrentUser() {
            //  Fetch data from firestore and store in Realm
            FirebaseService.shared.fetchData(for: user)
        } else {
            presentLogin()
        }
    
    }
    
    private func setupNavigationBar() {
        self.title = "Japanki"
        let barButton = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logoutUser))
        navigationItem.rightBarButtonItem = barButton
    }
    
    @objc private func logoutUser() {
        FirebaseService.shared.logout {
            self.presentLogin()
        }
    }
    
    @IBAction func optionsButtonClicked(_ sender: Any) {
        if let deckController = instantiateVC(from: "Deck", id: "deckController") as? DeckController {
            deckController.modalPresentationStyle = .fullScreen
            
            navigationController?.pushViewController(deckController, animated: true)
        }
    }
    
    func presentLogin() {
        if let loginController = instantiateVC(from: "Login", id: "loginControllerID") as? LoginController {
            loginController.modalPresentationStyle = .fullScreen
            present(loginController, animated: true, completion: nil)
        }
    }

}

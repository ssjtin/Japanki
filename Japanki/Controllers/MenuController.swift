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
        
        self.title = "Japanki"
        
        if FirebaseService.shared.checkCurrentUser() == nil {
            if let loginController = instantiateVC(from: "Login", id: "loginControllerID") as? LoginController {
                loginController.modalPresentationStyle = .fullScreen
                present(loginController, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func optionsButtonClicked(_ sender: Any) {
        if let deckController = instantiateVC(from: "Deck", id: "deckController") as? DeckController {
            deckController.modalPresentationStyle = .fullScreen
            
            navigationController?.pushViewController(deckController, animated: true)
        }
    }

}

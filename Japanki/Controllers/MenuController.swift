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
    }
    
    @IBAction func optionsButtonClicked(_ sender: Any) {
        if let deckController = instantiateVC(from: "Deck", id: "deckController") as? DeckController {
            deckController.modalPresentationStyle = .fullScreen
            
            navigationController?.pushViewController(deckController, animated: true)
        }
    }

}

//
//  NewCardController.swift
//  Japanki
//
//  Created by Hoang Luong on 16/8/20.
//

import UIKit

protocol NewCardDelegate: class {
    func newCardAdded()
}

class NewCardController: UIViewController {
    
    @IBOutlet weak var frontTextView: UITextView!
    
    @IBOutlet weak var backTextView: UITextView!
    
    @IBOutlet weak var deleteCardButton: UIButton!
    
    var currentEditingDeck: Deck?
    var currentEditingCard: Card?
    
    weak var delegate: NewCardDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let editCard = currentEditingCard {
            frontTextView.text = editCard.frontText
            backTextView.text = editCard.backText
            deleteCardButton.isHidden = false
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        guard !frontTextView.text.isEmpty else { return }
        
        if currentEditingCard == nil {
            saveNewCard()
        } else {
            updateCard()
        }
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteCardClicked(_ sender: Any) {
        if let card = currentEditingCard,
           let deck = currentEditingDeck {
            RealmService.shared.delete(card: card, in: deck)
        }
        
        delegate?.newCardAdded()
        
        navigationController?.popViewController(animated: true)
    }
    
    private func saveNewCard() {
        let newCard = Card()
        newCard.frontText = frontTextView.text
        newCard.backText = backTextView.text
        
        RealmService.shared.add(newCard, to: "Test Deck")
        
        delegate?.newCardAdded()
        
        navigationController?.popViewController(animated: true)
    }
    
    private func updateCard() {
        if let card = currentEditingCard,
           let deck = currentEditingDeck {
            RealmService.shared.updateDetails(card: card, in: deck, frontText: frontTextView.text, backText: backTextView.text)
        }
        
        delegate?.newCardAdded()
        
        navigationController?.popViewController(animated: true)
    }
    
}

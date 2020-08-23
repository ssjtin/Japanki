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
        
        frontTextView.delegate = self
        backTextView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.addGestureRecognizer(tapGesture)
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
    
    @objc private func backgroundTapped() {
        //  Text fields resign first responder
        view.endEditing(true)
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

extension NewCardController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.tag == 1 {
            if textView.text == "Front card text" {
                textView.text = ""
            }
        }
        if textView.tag == 2 {
            if textView.text == "Reverse card text" {
                textView.text = ""
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.tag == 1 {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = "Front card text"
            }
        }
        if textView.tag == 2 {
            if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                textView.text = "Reverse card text"
            }
        }
    }
}

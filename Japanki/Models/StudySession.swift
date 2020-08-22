//
//  StudySession.swift
//  Japanki
//
//  Created by Hoang Luong on 16/8/20.
//

import RealmSwift
import UIKit

class StudySession {
    
    let numberOfCards = 10
    
    var currentCardIndex = 0
    
    var deck: Deck
    
    var dueCards = [Card]()
    
    var cardExistsAtCurrentIndex: Bool {
        return currentCardIndex < deck.cards.count
    }
    
    init(deck: Deck) {
        self.deck = deck
        self.dueCards = deck.cards.filter { $0.nextDue < Date() }.shuffled()
        
        if dueCards.isEmpty, let randomCard = deck.cards.randomElement() {
            dueCards.append(randomCard)
        }
    }
    
    func incrementCardIndex() {
        currentCardIndex += 1
        _ = dueCards.removeFirst()
        
        if currentCardIndex < numberOfCards,
           dueCards.isEmpty,
           let randomCard = deck.cards.randomElement() {
            //  No more due cards, add a random card to redo
            dueCards.append(randomCard)
        }
    }
    
    func updateCurrentCard(success: Bool) {
        RealmService.shared.update(card: dueCards.first!, in: deck, success: success)
    }
    
}

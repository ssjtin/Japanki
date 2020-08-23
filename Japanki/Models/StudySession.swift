//
//  StudySession.swift
//  Japanki
//
//  Created by Hoang Luong on 16/8/20.
//

import RealmSwift
import UIKit
import FirebaseAuth

class StudySession {
    
    var deck: Deck
    
    var numberOfCards = 10
    var currentCardIndex = 0
    
    //  Split all cards into due cards + non due cards
    var dueCards = [Card]()
    var nonDueCards = [Card]()
    
    var hasMoreCards: Bool {
        return (dueCards.count + nonDueCards.count) > 1
    }
    
    var currentCard: Card? {
        return dueCards.first ?? nonDueCards.first
    }
    
    init(deck: Deck) {
        self.deck = deck
        self.dueCards = deck.cards.filter { $0.nextDue < Date() }.shuffled()
        
        self.nonDueCards = Array(Set(deck.cards).subtracting(Set(dueCards))).shuffled()
        
        self.numberOfCards = max(numberOfCards, dueCards.count + nonDueCards.count)
    }
    
    func incrementCardIndex() {
        currentCardIndex += 1
        if dueCards.count > 0 {
            dueCards.removeFirst()
        } else if nonDueCards.count > 0 {
            nonDueCards.removeFirst()
        }
    }
    
    func updateCurrentCard(success: Bool) {
        if dueCards.count > 0 {
            RealmService.shared.update(card: dueCards.first!, in: deck, success: success)
        } else {
            RealmService.shared.update(card: nonDueCards.first!, in: deck, success: success)
        }
    }
    
}

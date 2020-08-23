//
//  RealmService.swift
//  Japanki
//
//  Created by Hoang Luong on 15/8/20.
//

import Foundation
import RealmSwift

class RealmService {
    static let shared = RealmService()
    
    let realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func clear() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func fetch<T: Object>(type: T.Type) -> Results<T> {
        let objects = realm.objects(T.self)
        return objects
    }

    func write(_ deck: Deck) {
        try! realm.write {
            realm.add(deck)
        }
    }
    
    func add(_ card: Card, to deck: String) {
        try! realm.write {
            let testDeck = fetch(type: Deck.self).first!
            testDeck.cards.append(card)
        }
    }
    
    func delete(card: Card, in deck: Deck) {
        try! realm.write {
            let index = deck.cards.firstIndex(of: card)!
            deck.cards.remove(at: index)
        }
    }
    
    func updateDetails(card: Card, in deck: Deck, frontText: String, backText: String) {
        try! realm.write {
            let index = deck.cards.firstIndex(of: card)!
            deck.cards[index].frontText = frontText
            deck.cards[index].backText = backText
        }
    }
    
    //  Update last seen date to now, and box number as per Leitner system
    func update(card: Card, in deck: Deck, success: Bool) {
        try! realm.write {
            let index = deck.cards.firstIndex(of: card)!
            deck.cards[index].updateBoxNumber(success: success)
            deck.cards[index].lastSeen = Date()
            deck.cards[index].nextDue = Calendar.current.date(byAdding: .day, value: deck.cards[index].boxNumber, to: Date())!
        }
    }
    
}

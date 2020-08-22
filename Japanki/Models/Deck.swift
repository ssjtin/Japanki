//
//  Deck.swift
//  Japanki
//
//  Created by Hoang Luong on 16/8/20.
//

import Foundation
import RealmSwift

let numberOfCardBoxes = 5

class Deck: Object {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    let cards = List<Card>()
    
    var dueCardCount: Int {
        return cards.filter { $0.nextDue <= Date() }.count
    }
    
    var dueCardString: String {
        return Localized.dueCardString(dueCardCount)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

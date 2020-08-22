//
//  Localized.swift
//  Japanki
//
//  Created by Hoang Luong on 18/8/20.
//

import Foundation

struct Localized {
    static func dueCardString(_ numberOfCards: Int) -> String {
        let cardsFormat = NSLocalizedString("cards", tableName: "Localized", comment: "Number of cards")
        let cardsString = String.localizedStringWithFormat(cardsFormat, numberOfCards)
        
        let dueStringFormat = NSLocalizedString("dueCardsString", tableName: "Localized", comment: "Number of cards due")
        return String.localizedStringWithFormat(dueStringFormat, cardsString)
    }
}

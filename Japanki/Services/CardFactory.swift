//
//  CardFactory.swift
//  Japanki
//
//  Created by Hoang Luong on 9/8/20.
//

import Foundation

class CardFactory {
    
    func getTestCards() -> [Card] {
        do {
            if let bundlePath = Bundle.main.path(forResource: "Test",
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let cards = try JSONDecoder().decode([Card].self, from: jsonData)
                return cards
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
}

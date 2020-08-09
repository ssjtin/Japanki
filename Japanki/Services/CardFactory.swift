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
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                
                let cards = try decoder.decode([Card].self, from: jsonData)
                print(cards)
                return cards
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
}

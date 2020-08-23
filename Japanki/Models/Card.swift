//
//  Card.swift
//  Japanki
//
//  Created by Hoang Luong on 9/8/20.
//

import FirebaseFirestore
import Foundation
import RealmSwift

class Card: Object, Decodable, Identifiable {
    
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var frontText: String = ""
    @objc dynamic var backText: String = ""
    @objc dynamic var lastSeen: Date = Date()
    @objc dynamic var nextDue: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    @objc dynamic var boxNumber: Int = 1
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    let boxIntervalDictionary: [Int: Int] = [
        1 : 1,
        2 : 2,
        3 : 4,
        4 : 7,
        5 : 10
    ]
    
    var isDue: Bool {
        return nextDue < Date()
    }
    
    convenience init(data: [String: Any]) {
        self.init()
        
        guard let id = data["id"] as? String,
            let frontText = data["frontText"] as? String,
            let backText = data["backText"] as? String,
            let lastSeen = data["lastSeen"] as? Timestamp,
            let nextDue = data["nextDue"] as? Timestamp,
            let boxNumber = data["boxNumber"] as? Int else { return }
        
        self.id = id
        self.frontText = frontText
        self.backText = backText
        self.lastSeen = lastSeen.dateValue()
        self.nextDue = nextDue.dateValue()
        self.boxNumber = boxNumber
    }
    
    func updateBoxNumber(success: Bool) {
        if success {
            boxNumber = min(numberOfCardBoxes, boxNumber + 1)
        } else {
            boxNumber = max(1, boxNumber - 1)
        }
        //  Update lastSeen to current date/time
        lastSeen = Date()
        let startOfDay = Calendar.current.startOfDay(for: lastSeen)
        nextDue = Calendar.current.date(byAdding: .day, value: boxIntervalDictionary[boxNumber] ?? 1, to: startOfDay)!
        
        print(nextDue)
    }
}

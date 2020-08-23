//
//  AppOptions.swift
//  Japanki
//
//  Created by Hoang Luong on 22/8/20.
//

import Foundation

class AppOptions {
    
    static let shared = AppOptions()
    
    var cardsPerSession: Int = {
        return UserDefaults.standard.value(forKey: "cardsPerSession") as? Int ?? 10
    }()
    
    var showReverseSideFirst: Bool = {
        return UserDefaults.standard.value(forKey: "showReverseSideFirst") as? Bool ?? false
    }()
    
}

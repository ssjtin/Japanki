//
//  Card.swift
//  Japanki
//
//  Created by Hoang Luong on 9/8/20.
//
import Foundation

struct Card: Decodable, Identifiable {
    
    let id: String
    
    var frontText: String
    var backText: String
    var memoryScore: Int
}

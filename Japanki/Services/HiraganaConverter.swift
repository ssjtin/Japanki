//
//  HiraganaConverter.swift
//  Japanki
//
//  Created by Hoang Luong on 8/8/20.
//

import Foundation

class HiraganaConverter {
    
    private let url = URL(string: "https://labs.goo.ne.jp/api/hiragana")!
    private let app_id = "825ddbe87edf55fe3b3f069de2cb51473352b375a19347037802ccc263c881e3"
    private let session = URLSession.shared
    
    var request: URLRequest
    
    init() {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        self.request = request
    }
    
    enum Output: String {
        case Hiragana = "hiragana"
        case Katakana = "katakana"
    }
    
    func convert(kanjiString: String, completion: @escaping (String) -> Void) {
        let json = [
            "app_id": app_id,
            "sentence": kanjiString,
            "output_type": Output.Hiragana.rawValue
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        let task = session.uploadTask(with: request, from: jsonData) { data, response, error in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let convertedString = json["converted"] as? String {
                completion(convertedString)
            } else {
                completion("error")
            }
        }
        task.resume()
    }
}

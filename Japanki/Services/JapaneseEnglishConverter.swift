//
//  JapaneseEnglishConverter.swift
//  Japanki
//
//  Created by Hoang Luong on 8/8/20.
//

import Foundation

class JapaneseEnglishConverter {
    
    private let url = URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")!
    private let api_key = "iAxh0uuFXbmshSSNryuXON3gMGJfp1uTPPwjsnv7FcVcsaban6"
    private let session = URLSession.shared
    
    var request: URLRequest
    
    init() {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("google-translate1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        request.setValue(api_key, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("application/gzip", forHTTPHeaderField: "accept-encoding")
        self.request = request
    }
    
    func translateV2(text: String, completion: @escaping (String) -> Void) {

        let headers = [
            "x-rapidapi-host": "google-translate1.p.rapidapi.com",
            "x-rapidapi-key": "iAxh0uuFXbmshSSNryuXON3gMGJfp1uTPPwjsnv7FcVcsaban6",
            "accept-encoding": "application/gzip",
            "content-type": "application/x-www-form-urlencoded"
        ]

        let postData = NSMutableData(data: "source=ja".data(using: String.Encoding.utf8)!)
        postData.append("&q=\(text)".data(using: String.Encoding.utf8)!)
        postData.append("&target=en".data(using: String.Encoding.utf8)!)

        let request = NSMutableURLRequest(url: NSURL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if error != nil {
                //  Handle error
                completion("error")
            } else {
                if let data = data,
                   let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let dataDict = json["data"] as? [String: Any],
                   let translationsDict = dataDict["translations"] as? [[String: String]],
                   let firstTranslation = translationsDict.first,
                   let translation = firstTranslation["translatedText"] {
                    completion(translation)
                } else {
                    completion("error")
                }
            }
        })

        dataTask.resume()
    }

}

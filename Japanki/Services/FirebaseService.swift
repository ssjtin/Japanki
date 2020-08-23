//
//  FirebaseService.swift
//  Japanki
//
//  Created by Hoang Luong on 23/8/20.
//

import Firebase

class FirebaseService {
    
    static let shared = FirebaseService()
    
    let db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func fetchCards(deckID: String, completion: @escaping ([Card]) -> Void) {
        db.collection("decks").document(deckID).collection("cards").getDocuments { (snapshot, error) in
            var cards = [Card]()
            
            for document in snapshot!.documents {
                cards.append(Card(data: document.data()))
            }
            
            completion(cards)
        }
    }
    
    func checkCurrentUser() -> User? {
        if let user = Auth.auth().currentUser {
            //  Signed in user detected
            return user
        } else {
            return nil
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (User?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                //  Handle error
                print(error.localizedDescription)
              completion(nil)
            } else {
                //  Handle successful sign-up
              completion(authResult!.user)
            }
        }
    }
    
    func createUser(email: String, password: String, completion: @escaping (User?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
              if let error = error {
                  //  Handle error
                  print(error.localizedDescription)
                completion(nil)
              } else {
                  //  Handle successful sign-up
                completion(authResult!.user)
              }
          }
    }
    
}

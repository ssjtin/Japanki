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
    
    func fetchData(for user: User) {
        
        let dispatchGroup = DispatchGroup()
        
        //  Fetch deck ID's
        let deckRef = db.collection("users").document(user.uid).collection("userDecks").document("deckarray")
        deckRef.getDocument { (document, error) in
            if let document = document,
                let data = document.data(),
                let deckIds = data["ids"] as? [String] {
                //  Fetch decks
                for deckId in deckIds {
                    
                    let deck = Deck()
                    
                    let ref = self.db.collection("decks").document(deckId)
                    dispatchGroup.enter()
                    ref.getDocument { (snapshot, error) in
                        if let snapshot = snapshot, let data = snapshot.data(), let name = data["name"] as? String, let id = data["id"] as? String {
                            deck.id = id
                            deck.name = name
                        }
                        dispatchGroup.leave()
                    }
                    
                    let cardsRef = ref.collection("cards")
                    dispatchGroup.enter()
                    cardsRef.getDocuments { (snapshot, error) in
                        for doc in snapshot!.documents {
                            deck.cards.append(Card(data: doc.data()))
                        }
                        dispatchGroup.leave()
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        RealmService.shared.write(deck)
                    }
                }
            }
        }
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
    
    func logout(completion: @escaping () -> Void) {
        do {
            //  TODO: Clear realm
            try Auth.auth().signOut()
            RealmService.shared.clear()
            completion()
        } catch let error {
            //  Handle error
            print(error.localizedDescription)
            completion()
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

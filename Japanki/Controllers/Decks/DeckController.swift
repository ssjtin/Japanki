//
//  DeckController.swift
//  Japanki
//
//  Created by Hoang Luong on 16/8/20.
//

import RealmSwift
import UIKit

class DeckController: UITableViewController {
    
    let cellId = "cellId"
    
    var decks = [Deck]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let savedDecks = RealmService.shared.fetch(type: Deck.self)
        self.decks = Array(savedDecks)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        cell?.textLabel?.text = decks[indexPath.row].name + "    " + decks[indexPath.row].dueCardString
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Present deck details
        if let deckBreakdownController = instantiateVC(from: "Deck", id: "deckBreakdownController") as? DeckBreakdownController {
            deckBreakdownController.modalPresentationStyle = .fullScreen
            deckBreakdownController.selectedDeck = decks[indexPath.row]
            navigationController?.pushViewController(deckBreakdownController, animated: true)
        }
    }
    
}

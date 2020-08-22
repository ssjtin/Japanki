//
//  DeckBreakdownController.swift
//  Japanki
//
//  Created by Hoang Luong on 16/8/20.
//

import RealmSwift
import UIKit

class DeckBreakdownController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var selectedDeck: Deck!
    
    //  Layout constants
    let itemSpacing: CGFloat = 10
    let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "CardCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let newCardButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(newCardClicked))
        let studyButton = UIBarButtonItem(title: "Study Now", style: .plain, target: self, action: #selector(studyClicked))
        
        navigationItem.rightBarButtonItems = [studyButton, newCardButton]
    }
    
    @objc func studyClicked() {
        if let studyController = instantiateVC(from: "Main", id: "studyController") as? StudyController {
            studyController.modalPresentationStyle = .fullScreen
            
            let session = StudySession(deck: selectedDeck)
            
            studyController.studySession = session
            
            navigationController?.pushViewController(studyController, animated: true)
        }
    }
    
    @objc func newCardClicked() {
        if let newCardController = instantiateVC(from: "NewCardController", id: "newCardController") as? NewCardController {
            newCardController.modalPresentationStyle = .formSheet
            newCardController.delegate = self
            
            navigationController?.pushViewController(newCardController, animated: true)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedDeck.cards.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let newCardController = instantiateVC(from: "NewCardController", id: "newCardController") as? NewCardController {
            newCardController.modalPresentationStyle = .formSheet
            newCardController.delegate = self
            newCardController.currentEditingDeck = selectedDeck
            newCardController.currentEditingCard = selectedDeck.cards[indexPath.row]
            
            navigationController?.pushViewController(newCardController, animated: true)
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CardCell
        
        cell.textLabel.text = selectedDeck.cards[indexPath.row].frontText
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let fullWidth = collectionView.frame.width
        let itemWidth = ((fullWidth - CGFloat(itemsPerRow + 1) * itemSpacing) / itemsPerRow) - 5
        return CGSize(width: itemWidth, height: 150)
    }
    
}

extension DeckBreakdownController: NewCardDelegate {
    func newCardAdded() {
        collectionView.reloadData()
    }
}

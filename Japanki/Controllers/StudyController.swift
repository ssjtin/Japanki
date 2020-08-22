//
//  StudyController.swift
//  Japanki
//
//  Created by Hoang Luong on 15/8/20.
//

import RealmSwift
import UIKit

class StudyController: UIViewController {
    
    enum Side {
        case Front
        case Back
        
        mutating func toggle() {
            self = self == .Front ? .Back : .Front
        }
    }
    
    var studySession: StudySession!
    var showingSide: Side = .Front
    
    @IBOutlet weak var frontLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatePresentedCard()
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(frontLabelLongPressed))
        longPressGesture.delaysTouchesEnded = true
        frontLabel.isUserInteractionEnabled = true
        frontLabel.addGestureRecognizer(longPressGesture)
    }
    
    @IBAction func flipButtonClicked(_ sender: Any) {
        showingSide.toggle()
        updatePresentedCard()
    }
    
    
    @IBAction func successButtonClicked(_ sender: Any) {
        handleCardCompleted(success: true)
    }
    
    @IBAction func failButtonClicked(_ sender: Any) {
        handleCardCompleted(success: false)
    }
    
    @objc func frontLabelLongPressed(gesture: UIGestureRecognizer) {
        guard gesture.state == .ended else { return }
        if let text = frontLabel.text {
            HiraganaConverter.shared.convert(kanjiString: text) { (hiragana) in
                DispatchQueue.main.async {
                    self.frontLabel.text = text + "\n\n" + hiragana
                }
            }
        }
    }
    
    func handleCardCompleted(success: Bool) {
        studySession.updateCurrentCard(success: success)
        
        if studySession.currentCardIndex < studySession.numberOfCards - 1 {
            studySession.incrementCardIndex()
            showingSide = .Front
            updatePresentedCard()
        } else {
            //  Finished
            let alertController = UIAlertController(title: "Session Complete", message: "You've studied \(studySession.numberOfCards) cards!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Close", style: .default) { (_) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func updatePresentedCard() {
        if let currentCard = studySession.dueCards.first {
            frontLabel.text = showingSide == .Front ? currentCard.frontText : currentCard.backText
        }
    }
    
}

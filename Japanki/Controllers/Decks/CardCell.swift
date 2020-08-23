//
//  CardCell.swift
//  Japanki
//
//  Created by Hoang Luong on 16/8/20.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dueLabel.isHidden = true
    }
    
    func configure(for card: Card) {
        textLabel.text = card.frontText
        dueLabel.isHidden = !card.isDue
    }
}

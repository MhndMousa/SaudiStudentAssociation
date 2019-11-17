//
//  CardCell.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/23/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

@IBDesignable class CardHighlightCell: UITableViewCell, CardDelegate {

    var event : EventInformation!
    
    @IBOutlet weak var card: CardHighlight!
    override func awakeFromNib() {
        super.awakeFromNib()
        card.shadowOpacity = 0
    }

    
    func populate(_ event: EventCellInfo) {
        card.title = String( describing: event.title)
//        card.itemTitle = String( describing: event.itemTitle!)
//        card.itemSubtitle = String( describing: event.itemSubtitle!)
//        card.backgroundColor = event.backgroundColor!
//        card.icon = event.image
//        card.textColor = event.textColor!
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.event = nil
    }
    
}

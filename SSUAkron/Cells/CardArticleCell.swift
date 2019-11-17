////
////  CardArticleCell.swift
////  SSUAkron
////
////  Created by Muhannad Mousa on 3/24/18.
////  Copyright © 2018 Muhannad Mousa. All rights reserved.
////
//
//import UIKit
//
//class CardArticleCell: UITableViewCell {
//
//    @IBOutlet weak var card: CardArticle!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
//    
//    // TODO: Automate the population of the card
//    func populate(_ event: EventCellInfo) {
//        
//        card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
//        //            cell.card?.backgroundImage = self.imageArray[0]
//        
//        card.title = event.title
////        card.subtitle = event.itemSubtitle ?? ""
//        card.category = event.catagory ?? ""
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        
//        //set cell to initial state here
//        //set like button to initial state - title, font, color, etc.
//    }
//    
//}

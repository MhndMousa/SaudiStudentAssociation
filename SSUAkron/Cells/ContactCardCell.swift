//
//  ContactCardCell.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/6/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class ContactCardCell: UICollectionViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var jobLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    
    @IBAction func contactButtonClicked(_ sender: UIButton) {
        sender.tap()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contactButton.layer.cornerRadius = 8
        
        contactButton.alpha = 0.8
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.image = UIImage(named: "Unknown_Person")
        nameLabel.text = ""
        jobLabel.text = ""
        
    }
}

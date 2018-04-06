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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.image = UIImage(named: "Unknown_Person")
        nameLabel.text = ""
        jobLabel.text = ""
        
    }
}

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
    @IBOutlet weak var buttonView: UIView!
    
    var whatsAppNumber: String?
    
    @IBAction func contactButtonClicked(_ sender: UIButton) {
        
        guard whatsAppNumber != nil else { return }
        guard let url = URL(string: "https://wa.me/\(whatsAppNumber)") else { return }
        UIApplication.shared.open(url)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonView.backgroundColor = whatsAppNumber == nil ? .gray : .blueSSA
        buttonView.isUserInteractionEnabled = whatsAppNumber == nil
        buttonView.layer.cornerRadius = buttonView.bounds.width / 2
        contactButton.alpha = 0.8
        layer.cornerRadius = 10
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView?.image = UIImage(named: "Unknown_Person")
        nameLabel.text = ""
        jobLabel.text = ""
        
    }
}



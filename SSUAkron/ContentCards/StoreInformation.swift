//
//  StoreInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/2/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class StoreInformation: UIViewController {
    @IBOutlet weak var DescriptionContainer: UIView!
    @IBOutlet weak var costView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var photosView: UIView!
    
    @IBOutlet weak var descriptionView: UITextView!
    
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var whereToRecieveLabel: UILabel!
    
    @IBOutlet weak var messageButton: UIButton!
    
    @IBAction func messageTapped(_ sender: Any) {
        // Open a new message with uid of the item poster
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        costView.layer.cornerRadius = 12
        messageView.layer.cornerRadius = 12
        typeView.layer.cornerRadius = 12
        photosView.layer.cornerRadius = 12
        descriptionView.layer.cornerRadius = 12
        DescriptionContainer.layer.cornerRadius = 12
        messageButton.layer.cornerRadius = 12
        descriptionView.font = UIFont(name: "NotoKufiArabic", size: 12)
    }


}

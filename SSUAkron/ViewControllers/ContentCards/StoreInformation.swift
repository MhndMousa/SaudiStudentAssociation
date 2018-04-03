//
//  StoreInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/2/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class StoreInformation: UIViewController {

    @IBOutlet weak var costView: UIView!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var photosView: UIView!
    @IBOutlet weak var DescriptionContainer: UIView!
    
    
    
    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var whereToRecieveLabel: UILabel!
    
    @IBAction func messageTapped(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        costView.layer.cornerRadius = 12
        messageView.layer.cornerRadius = 12
        typeView.layer.cornerRadius = 12
        photosView.layer.cornerRadius = 12
        descriptionView.layer.cornerRadius = 12
        DescriptionContainer.layer.cornerRadius = 12
        messageButton.layer.cornerRadius = 12
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

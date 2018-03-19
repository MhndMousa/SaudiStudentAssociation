//
//  Store.swift
//  Akron
//
//  Created by Muhannad Mousa on 3/19/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit
import Cards

class Store: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //firebase pulling all data and stuff
        //on click would refresh the data contaier
        
        
        let card = CardHighlight(frame: CGRect(x: 20, y: 30, width: 200, height: 300))
        card.itemTitle = "something"
    
        
        self.view.addSubview(card)
        
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

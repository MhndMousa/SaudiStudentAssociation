//
//  ViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/15/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var card: CardHighlight!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Aspect Ratio of 5:6 is preferred
//        let card = CardHighlight(frame: CGRect(x: 10, y: 30, width: 200 , height: 240))
//
//        card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
//        card.icon = UIImage(named: "ssa")
//        card.title = "النادي \nالسعودي \nبجامعة \nاكرون !"
//        card.itemTitle = "المبتقي على الراتب"
//        card.itemSubtitle = "اي شي!"
//        card.textColor = UIColor.white

//        card.hasParallax = true

        
        
       
        let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "CardContent")

        card?.shouldPresent(cardContentVC, from: self, fullscreen: false)

        
        self.view.addSubview(card)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}






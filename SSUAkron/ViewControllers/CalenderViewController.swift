//
//  InfoViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/19/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class CalenderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        var colors = [UIColor.init(red: 1, green: 0.7, blue: 0.7, alpha: 1), UIColor.blue, UIColor.orange]
        var cat = ["تجمع نسائي", "تجمع رجال " , "تجمع للاطفال"]
        for i in 0...2 {
            let card = CardHighlight(frame: CGRect(x: 15, y: 30 + (210 * CGFloat(i)), width: view.frame.width - 30 , height: 200))

            card.backgroundColor = colors[i]
            card.icon = UIImage(named: "ssa")
            card.title = "ايفينت"
            card.itemTitle = cat[i]
            card.itemSubtitle = "نوع الايفينت"
            card.textColor = UIColor.white
            
            card.hasParallax = true
            let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "EventCard")
            
            card.shouldPresent(cardContentVC, from: self, fullscreen: false)
            
            
            self.view.addSubview(card)
        }
        
        
        
        
        
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

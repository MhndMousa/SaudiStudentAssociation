//
//  StoreViewController.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/19/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    var imageArray = [UIImage]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        imageArray = [#imageLiteral(resourceName: "car1"),#imageLiteral(resourceName: "car3"),#imageLiteral(resourceName: "car2")]

        for i in 0..<imageArray.count {
            
            let card = CardArticle(frame: CGRect(x: 15, y: 30 + (250 * CGFloat(i)), width: view.frame.width - 30 , height: 240))
            
            card.backgroundColor = UIColor(red: 0, green: 94/255, blue: 112/255, alpha: 1)
            card.backgroundImage = imageArray[i]
            
            card.title = "كامري"
            card.subtitle = "وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف وصف"
            card.category = "سيارة"

            card.textColor = UIColor.white
            card.hasParallax = true
            
            let cardContentVC = storyboard!.instantiateViewController(withIdentifier: "StoreCard")
            card.shouldPresent(cardContentVC, from: self, fullscreen: false)
            self.view.addSubview(card)
            

        }

        
//        scrollview?.frame = view.frame
//        for i in 0..<imageArray.count{
//            let imageView = UIImageView()
//            imageView.image = imageArray[i]
//            imageView.contentMode = .scaleAspectFit
//
//            let x = self.view.frame.width * CGFloat(i)
//            imageView.frame = CGRect(x: x, y: 0,
//                                     width: self.view.frame.width,
//                                     height: 400 )
//
//            scrollview?.contentSize.width = (scrollview?.frame.width)! * CGFloat(i + 1)
//            scrollview?.addSubview(imageView)
//        }
        
        
        
     
        
        
        
        
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

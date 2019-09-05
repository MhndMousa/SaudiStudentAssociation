//
//  StoreInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/2/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class StoreInformation: UIViewController,UIScrollViewDelegate {

//    @IBOutlet weak var costView: UIView!
//    @IBOutlet weak var messageView: UIView!
//    @IBOutlet weak var typeView: UIView!
//    @IBOutlet weak var photosView: UIView!
//    @IBOutlet weak var DescriptionContainer: UIView!
//    @IBOutlet weak var descriptionView: UITextView!
//    @IBOutlet weak var typeLabel: UILabel!
    var imageArray : [UIImage] = []
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var photoCarouselScrollView: UIScrollView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var whereToRecieveLabel: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    
    @IBAction func messageTapped(_ sender: UIButton) {
        // Open a new message with uid of the item poster
        sender.tap()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        messageButton.layer.cornerRadius = messageButton.frame.height / 2
        
        imageArray = [#imageLiteral(resourceName: "car2"),#imageLiteral(resourceName: "car3"),#imageLiteral(resourceName: "car2")]
        
        
        for i in 0..<imageArray.count{
            let imageview = UIImageView()
            imageview.image = imageArray[i]
            let x = self.view.frame.width * CGFloat(i)
            imageview.frame = CGRect(x: x, y: 0, width: self.photoCarouselScrollView.frame.width, height: self.photoCarouselScrollView.frame.height)
            imageview.contentMode = .scaleAspectFit
            photoCarouselScrollView.contentSize.width = photoCarouselScrollView.frame.width * CGFloat(i + 1)
            photoCarouselScrollView.addSubview(imageview)
            
        }
        
        
        pageControl.numberOfPages = imageArray.count
        

    }

    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    
    }
    
    
    

}

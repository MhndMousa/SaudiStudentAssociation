//
//  StoreInformation.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 4/2/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import UIKit

class StoreInformationViewController: UIViewController,UIScrollViewDelegate {

    // MARK: Properties

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var photoCarouselScrollView: UIScrollView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var whereToRecieveLabel: UILabel!
    @IBOutlet weak var descriptionView: UILabel!
    
    var costString = ""
    var whereToRecieveString = ""
    var descriptionString = ""
    var imageArray : [UIImage] = []
    var whatsAppNumber :String?
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
       super.viewDidLoad()
       updateInfo()
       messageButton.layer.cornerRadius = messageButton.frame.height / 2
       photoCarouselScrollView.backgroundColor = UIColor(white: 0.94, alpha: 1)
       pageControl.numberOfPages = imageArray.count
   }

    // MARK: Handlers

    @IBAction func messageTapped(_ sender: UIButton) {
        // Open a new message with uid of the item poster
        sender.tap()
        print(whatsAppNumber)
        guard whatsAppNumber != nil else {
            showAlert(title: "حدث خطأ", message:"صاحب الاعلان لم يضع رقمه")
            return
        }
        if let number = whatsAppNumber{
            guard let url = URL(string: "https://wa.me/\(number)") else { return }
            UIApplication.shared.open(url)
        }
        
    }

    // MARK: Helpers

    func updateInfo() {
        print(costString)
        costLabel.text = costString
        whereToRecieveLabel.text = whereToRecieveString
        descriptionView.text = descriptionString
        for i in 0..<imageArray.count{
            let imageview = UIImageView()
            imageview.image = imageArray[i]
            let x = self.view.frame.width * CGFloat(i)
            imageview.frame = CGRect(x: x, y: 0, width: self.photoCarouselScrollView.frame.width, height: self.photoCarouselScrollView.frame.height)
            imageview.contentMode = .scaleAspectFit
            photoCarouselScrollView.contentSize.width = photoCarouselScrollView.frame.width * CGFloat(i + 1)
            photoCarouselScrollView.addSubview(imageview)
        }
    }
}

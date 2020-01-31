//
//  Global.swift
//  SSUAkron
//
//  Created by Muhannad Mousa on 3/20/18.
//  Copyright © 2018 Muhannad Mousa. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var ref : DatabaseReference! =  Database.database().reference()
let storageRef: StorageReference = Storage.storage().reference()


func wrapContent(view: UIScrollView)  {
    var contentRect = CGRect.zero

    for subview in view.subviews {
        contentRect = contentRect.union(subview.frame )
    }
    
    contentRect.size.height += UITabBar().frame.size.height + 10
    view.contentSize = contentRect.size
}


func wrapContent(cell: UITableViewCell) ->CGFloat {
    var contentRect = CGRect.zero
    
    for subview in cell.subviews {
        contentRect = contentRect.union(subview.frame )
    }
    
    contentRect.size.height += UITabBar().frame.size.height + 10
    return contentRect.size.height
}


func addBlurStatusBar(view: UIViewController) {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let blur = UIBlurEffect(style: .dark)
    let blurStatusBar = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: view.view.bounds.width, height: statusBarHeight))
    blurStatusBar.effect = blur
        view.view.addSubview(blurStatusBar)
    
}


func printFuocused(a : Any)  {
    print("--------------------------------------------------")
    print(a)
    print("--------------------------------------------------")
}

func refreshCurrentUserInfo() {
    currentUser = getUserInfo()
}



func getUserInfo() -> SaudiUser {
    let currentUser = Auth.auth().currentUser
    let user = SaudiUser()
    if let uid = currentUser?.uid{
        let ref = Database.database().reference().child("users").child(uid)
            ref.observe(.value) { (snapshot) in
                let value = snapshot.value as! [String: Any]
                
                user.name = value["name"] as? String
                user.email = value["email"] as? String
                user.uid = currentUser?.uid
                user.major = value["major"] as? String
                user.phoneNumber = value["phone_number"] as? String
                user.university = value["university"] as? String
                user.job = value["job"] as? String 
        }
    }
    return user
}





public func updateIcon(_ name: String) -> UIImage{
    print(name)
    if name == "food" {return UIImage(fromAssets: .food)}
    if name == "woman" {return UIImage(fromAssets: .woman)}
    if name == "sports" {return UIImage(fromAssets: .sports)}
    if name == "message" {return UIImage(fromAssets: .message)}
    if name == "fastfood" {return UIImage(fromAssets: .fastfood)}
    
    if name == "auto" {return UIImage(fromAssets: .auto)}
    if name == "electronics" {return UIImage(fromAssets: .electronics)}
    if name == "appliances" {return UIImage(fromAssets: .appliances)}
    if name == "books" {return UIImage(fromAssets: .books)}
    
    
    
    return UIImage()
    
}


extension UIImage{
    
    enum storeIcons:String{
        case auto = "commute_black"
        case electronics =  "computer_black"
        case books = "book_black"
        case appliances = "house_black"
        static let values = [auto,electronics,books,appliances ]
        
    }
    
    enum eventIcons :String {
        case food = "food_black"
        case fastfood = "fastfood_black"
        case woman = "woman_black"
        case sports = "sports_black"
        case message = "message_black"
        static let values = [food,woman,fastfood, sports, message]
        
        
        
        
    }
    convenience init!(fromAssets : eventIcons) {
        self.init(named: fromAssets.rawValue)
    }
    convenience init!(fromAssets : storeIcons) {
        self.init(named: fromAssets.rawValue)
    }
    
}





extension UIColor {
    
    // MARK: - Initialization
    
    class var blueSSA : UIColor { return UIColor(hex: "167CAA")! }
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
        
    }
    
    
    
}


extension UIView{
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                centerx : NSLayoutXAxisAnchor? = nil,
                centery: NSLayoutYAxisAnchor? = nil,
                padding : UIEdgeInsets = .zero,
                size: CGSize = .zero){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            topAnchor.constraint(equalTo: top, constant:  padding.top).isActive = true
        }
        if let centery = centery{
            centerYAnchor.constraint(equalTo: centery).isActive = true
        }
        if let centerx = centerx{
            centerXAnchor.constraint(equalTo: centerx).isActive = true
        }
        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant:  -padding.bottom).isActive = true
        }
        if let leading = leading{
            leadingAnchor.constraint(equalTo: leading, constant:  padding.left).isActive = true
        }
        if let trailing = trailing{
            trailingAnchor.constraint(equalTo: trailing, constant:  -padding.right).isActive = true
        }
        
        if size.width != 0{
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0{
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
    
    
    func fillSuperView(){
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
   

}



extension UIViewController {
    
    func showAlert(title: String = "Error", message: String = "Something went wrong") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    
    func updateNavBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.notoKufiArabicSmall]
            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white ,.font: UIFont.notoKufiBoldArabicExtraLarge]
            navBarAppearance.backgroundColor = .blueSSA
            navigationController?.navigationBar.standardAppearance = navBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
        
    func addReloadingIndicator(for seconds: TimeInterval) {
        let indicator = UIActivityIndicatorView()
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        indicator.widthAnchor.constraint(equalToConstant: 200).isActive = true
        indicator.heightAnchor.constraint(equalToConstant: 200).isActive = true
        indicator.hidesWhenStopped = true
        indicator.activityIndicatorViewStyle = .gray
        
        DispatchQueue.main.async {
            indicator.startAnimating()
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: {
                indicator.removeFromSuperview()
                indicator.stopAnimating()
            })
            
        }
    }
    
}







extension UIButton{
    func pulse()  {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.96
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount  = 1
        pulse.initialVelocity = 0.6
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
    }
    
    
    func tap()  {
        
        UIButton.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }) { _ in
            UIButton.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        }
    }
}

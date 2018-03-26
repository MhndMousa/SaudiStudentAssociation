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

extension UIColor {
    
    // MARK: - Initialization
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.characters.count
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

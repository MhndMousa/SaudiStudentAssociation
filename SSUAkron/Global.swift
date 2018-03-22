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

func addBlurStatusBar(view: UIViewController) {
    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let blur = UIBlurEffect(style: .dark)
    let blurStatusBar = UIVisualEffectView(frame: CGRect(x: 0, y: 0, width: view.view.bounds.width, height: statusBarHeight))
    blurStatusBar.effect = blur
        view.view.addSubview(blurStatusBar)
    
}

//
//  UIView + Extension.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 3/8/20.
//  Copyright © 2020 Muhannad Mousa. All rights reserved.
//

import Foundation
import UIKit

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



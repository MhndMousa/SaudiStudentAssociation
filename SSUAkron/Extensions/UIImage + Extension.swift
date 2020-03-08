//
//  UIImage + Extension.swift
//  SSUAkron
//
//  Created by Muhannad Alnemer on 3/8/20.
//  Copyright © 2020 Muhannad Mousa. All rights reserved.
//

import UIKit

extension UIImage{
    convenience init!(fromAssets : eventIcons) {
        self.init(named: fromAssets.rawValue)
    }
    convenience init!(fromAssets : storeIcons) {
        self.init(named: fromAssets.rawValue)
    }
}

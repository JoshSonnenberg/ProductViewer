//
//  UIColor+Utils.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/22/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

extension UIColor {
    
    typealias ColorComponents = (R: CGFloat, G: CGFloat, B: CGFloat)
    
    convenience init(hex: Int) {
        let components: ColorComponents = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        
        self.init(components: components)
    }
    
    convenience init(components: ColorComponents) {
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}

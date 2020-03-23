//
//  NibLoadable.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/22/20.
//  Copyright © 2020 Target. All rights reserved.
//

import Foundation
import UIKit

protocol NibLoadable: class {
    
    static var nibName: String { get }
    static var nibBundle: Bundle { get }
    static var nib: UINib { get }
    
}

extension NibLoadable where Self: UIView {
    
    static var nibName: String {
        return "\(self.self)"
    }
    
    static var nibBundle: Bundle {
        return Bundle(for: self.self)
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: nibBundle)
    }
    
    static var fromNib: Self {
        return nib.instantiate(withOwner: nil, options: nil).first as! Self
    }
    
}

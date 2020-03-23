//
//  UIView+Utils.swift
//  ProductViewer
//
//  Created by Josh Sonnenberg on 3/22/20.
//  Copyright © 2020 Target. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorner(corners: UIRectCorner, radius: CGFloat, borderWidth: CGFloat = 0.0, borderColor: UIColor = .clear) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
        
        self.addBorder(color: borderColor, width: borderWidth, radius: radius, path: maskPath)
    }
    
    func addBorder(color: UIColor, width: CGFloat, radius: CGFloat, path: UIBezierPath? = nil) {
        let path = path ?? UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        let border = CAShapeLayer()
        
        border.name = "view_border_layer"
        border.path = path.cgPath
        border.lineWidth = width * 2
        
        border.fillColor = UIColor.clear.cgColor
        border.strokeColor = color.cgColor
        
        self.layer.sublayers?.forEach { if $0.name == "view_border_layer" { $0.removeFromSuperlayer() }}
        self.layer.addSublayer(border)
    }
    
}

//
//  circleView.swift
//  BahamaAirLoginScreen
//
//  Created by Joseph Duran on 8/13/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//
import UIKit
@IBDesignable
class circleView: UIView {
    
    @IBInspectable var fillColor: UIColor = UIColor(red: 22/255, green: 50/255, blue: 118/255, alpha: 0.5)

    
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
    }
    
    
    
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.cornerRadius = cornerRadius
//            layer.masksToBounds = cornerRadius > 0
//        }
//    }
//    @IBInspectable var borderWidth: CGFloat = 0 {
//        didSet {
//            layer.borderWidth = borderWidth
//        }
//    }
//    @IBInspectable var borderColor: UIColor? {
//        didSet {
//            layer.borderColor = borderColor?.CGColor
//        }
//    }
}



//class Layer1View: UIView {
//    override func drawRect(rect: CGRect) {
//        var path = UIBezierPath(ovalInRect: rect)
//        UIColor(red: 13/255, green: 151/255, blue: 255/255, alpha: 1.0).setFill()
//        path.fill()
//    }
//}
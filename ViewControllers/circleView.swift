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
        let path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
    }
}


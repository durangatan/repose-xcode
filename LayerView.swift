//
//  Layer1View.swift
//  NicksOrb
//
//  Created by Apprentice on 8/16/16.
//  Copyright © 2016 Apprentice. All rights reserved.
//

import UIKit

class Layer1View: UIView {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor(red: 13/255, green: 151/255, blue: 255/255, alpha: 1.0).setFill()
        path.fill()
    }
}

class Layer2View: UIView {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor(red: 94/255, green: 186/255, blue: 255/255, alpha: 1.0).setFill()
        path.fill()
    }
}

class Layer3View: UIView {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor(red: 200/255, green: 227/255, blue: 255/255, alpha: 1.0).setFill()
        path.fill()
    }
}

class Layer4View: UIView {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).setFill()
        path.fill()
    }
}

class OrbIntroView: UIView {
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        UIColor(red: 13/255, green: 151/255, blue: 255/255, alpha: 1.0).setFill()
        path.fill()
    }
}
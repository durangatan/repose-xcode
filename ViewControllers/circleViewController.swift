//
//  circleViewController.swift
//  BahamaAirLoginScreen
//
//  Created by Joseph Duran on 8/13/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

import UIKit
import Dispatch
class circleViewController: UIViewController{
    
    @IBOutlet weak var theOrb: circleView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.theOrb.center.x = 0
        self.theOrb.center.y = 0
        UIView.animateWithDuration(5, delay: 0.3, options:[.Repeat, .CurveEaseInOut, .Autoreverse], animations:{
            let rotation = CGAffineTransformMakeRotation(1.571)
            self.theOrb.frame.size.width += 200
            self.theOrb.frame.size.height += 200
            self.theOrb.transform = rotation
            self.theOrb.cornerRadius += 100
            self.theOrb.alpha += 0.75
            }, completion: nil);
    }
}
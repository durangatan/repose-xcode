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
        self.theOrb.frame = CGRectMake(160, 240, 50, 50);
        self.theOrb.center = CGPointMake(self.view.frame.size.width  / 2,
                                         self.view.frame.size.height / 2);
        UIView.animateWithDuration(5, delay: 0.3, options:[.Repeat, .CurveEaseInOut, .Autoreverse], animations:{

            }, completion: nil);
    }
}
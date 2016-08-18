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
    
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var instructions2: UILabel!
    @IBOutlet weak var breatheIn: UILabel!
    @IBOutlet weak var breatheOut: UILabel!
    
    @IBOutlet weak var Layer1: Layer1View!
    @IBOutlet weak var Layer2: Layer2View!
    @IBOutlet weak var Layer3: Layer3View!
    @IBOutlet weak var Layer4: Layer4View!
    @IBOutlet weak var Intro: OrbIntroView!
    
    var timer = NSTimer()
    
    
    func orbAnimateMethod()
    {
        
        UIView.animateWithDuration(4.5, delay: 1.60, options: [], animations: {
            print(String("test"))

            self.Layer1.frame = CGRectMake(
                self.Layer1.center.x - 150,
                self.Layer1.center.y - 150,
                self.Layer1.bounds.width + 200,
                self.Layer1.bounds.height + 200
            )

            
            }, completion: {(Bool) -> Void in UIView.animateWithDuration(3.5, delay: 1.60, options: [], animations: {
                self.Layer1.frame = CGRectMake(
                    self.Layer1.center.x - 50,
                    self.Layer1.center.y - 50,
                    self.Layer1.bounds.width - 200,
                    self.Layer1.bounds.width - 200
                )

                UIView.performWithoutAnimation { () -> Void in
                    self.instructions.layoutIfNeeded()
                }
                }, completion: nil)})
        

        
        UIView.animateWithDuration(4.5, delay: 1.40, options: [], animations: {
            self.Layer2.frame = CGRectMake(
                self.Layer2.center.x - 125,
                self.Layer2.center.y - 125,
                self.Layer2.bounds.width + 160,
                self.Layer2.bounds.height + 160
            )
            
            }, completion: {(Bool) -> Void in UIView.animateWithDuration(3.5, delay: 1.40, options: [], animations: {
                
                self.Layer2.frame = CGRectMake(
                    self.Layer2.center.x - 45,
                    self.Layer2.center.y - 45,
                    self.Layer2.bounds.width - 160,
                    self.Layer2.bounds.height - 160
                )}, completion: nil)})
        
        UIView.animateWithDuration(4.5, delay: 1.20, options: [], animations: {
            self.Layer3.frame = CGRectMake(
                self.Layer3.center.x - 85,
                self.Layer3.center.y - 85,
                self.Layer3.bounds.width + 90,
                self.Layer3.bounds.height + 90
            )
        
            }, completion: {(Bool) -> Void in UIView.animateWithDuration(3.5, delay: 1.20, options: [], animations: {
        
                    self.Layer3.frame = CGRectMake(
                        self.Layer3.center.x - 40,
                        self.Layer3.center.y - 40,
                        self.Layer3.bounds.width - 90,
                        self.Layer3.bounds.height - 90
                    )}, completion: nil)})
        
        UIView.animateWithDuration(4.5, delay: 1.00, options: [], animations: {

            self.Layer4.frame = CGRectMake(
                self.Layer4.center.x - 70,
                self.Layer4.center.y - 70,
                self.Layer4.bounds.width + 70,
                self.Layer4.bounds.height + 70
            )
            
            
            }, completion: {(Bool) -> Void in UIView.animateWithDuration(3.5, delay: 1.00, options: [], animations: {

                self.Layer4.frame = CGRectMake(
                    self.Layer4.center.x - 35,
                    self.Layer4.center.y - 35,
                    self.Layer4.bounds.width - 70,
                    self.Layer4.bounds.height - 70
                )}, completion: nil)})
        
        UIView.animateWithDuration(2.0, delay: 0.0, options: [], animations: {
            self.instructions.alpha = 0.0
            self.instructions2.alpha = 0.0
            self.breatheOut.alpha = 0.0
            self.breatheIn.alpha = 1.0
            
            }, completion: {(Bool) -> Void in UIView.animateWithDuration(2.5, delay: 3.5, options: [], animations: {
                self.breatheOut.alpha = 1.0
                self.breatheIn.alpha = 0.0
            }, completion: nil)})
    }


    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.instructions.alpha = 0.0
        self.instructions2.alpha = 0.0
        self.breatheIn.alpha = 0.0
        self.breatheOut.alpha = 0.0
    }
    
    
    override func viewDidAppear(animated: Bool) {

        UIView.animateWithDuration(5.0, delay: 1.0, options: [], animations: {
            self.instructions.alpha = 1.0
            self.instructions2.alpha = 0.0
            
            }, completion: {(Bool) -> Void in     UIView.animateWithDuration(5.0, delay: 0.0, options: [], animations: {
                self.Intro.alpha = 0.0
                self.instructions.alpha = 0.0
                self.instructions2.alpha = 1.0
                
                }, completion: nil)})
        
        timer = NSTimer.scheduledTimerWithTimeInterval(11.0, target: self, selector: #selector(circleViewController.orbAnimateMethod), userInfo: nil, repeats: true)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
        
    }
        
    
}
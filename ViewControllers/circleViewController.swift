//
//  circleViewController.swift
//  BahamaAirLoginScreen
//
//  Created by Joseph Duran on 8/13/16.
//  Copyright © 2016 Razeware LLC. All rights reserved.
//

extension UIView {
    
//    func fadeTransition(duration:CFTimeInterval) {
//        let animation:CATransition = CATransition()
//        animation.timingFunction = CAMediaTimingFunction(name:
//            kCAMediaTimingFunctionEaseInEaseOut)
//        animation.type = kCATransitionFade
//        animation.duration = duration
//        self.layer.addAnimation(animation, forKey: kCATransitionFade)
//    }
}

import UIKit
import Dispatch
class circleViewController: UIViewController{
    
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var Layer1: Layer1View!
    
    var index : Int = 1
    
    var myArray:[String] = ["1", "2", "3", "4", "5"]
    
    func textTransition() {
        print(index)
        
        let pictureString:String = self.myArray[index]
        self.instructions.fadeTransition(1.0)
        self.instructions.text = pictureString
        index = (index < myArray.count-1) ? index+1 : 0
    }
    
    func orbAnimateMethod()
    {
        
        UIView.animateWithDuration(4.5, delay: 1.0, options: [], animations: {
            print(String("test"))
            //            print(String(self.Layer1.center.x))
            //            print(String(self.Layer1.center.y))
            //            print(String(self.Layer1.bounds.width))
            //            print(String(self.Layer1.bounds.height))
            //            print(String(self.Layer2.center.x))
            //            print(String(self.Layer2.center.y))
            //            print(String(self.Layer3.center.x))
            //            print(String(self.Layer3.center.y))
//            self.instructions.text = "Breath in..."
            
            self.Layer1.frame = CGRectMake(
                self.Layer1.center.x - 150,
                self.Layer1.center.y - 150,
                self.Layer1.bounds.width + 200,
                self.Layer1.bounds.height + 200
            )
//            self.Layer2.frame = CGRectMake(
//                self.Layer2.center.x - 125,
//                self.Layer2.center.y - 125,
//                self.Layer2.bounds.width + 160,
//                self.Layer2.bounds.height + 160
//            )
//            self.Layer3.frame = CGRectMake(
//                self.Layer3.center.x - 80,
//                self.Layer3.center.y - 80,
//                self.Layer3.bounds.width + 80,
//                self.Layer3.bounds.height + 80
//            )
            
            
            
            }, completion: {(Bool) -> Void in UIView.animateWithDuration(3.5, delay: 1.0, options: [], animations: {
                self.Layer1.frame = CGRectMake(
                    self.Layer1.center.x - 50,
                    self.Layer1.center.y - 50,
                    self.Layer1.bounds.width - 200,
                    self.Layer1.bounds.width - 200
                )
//                self.Layer2.frame = CGRectMake(
//                    self.Layer2.center.x - 45,
//                    self.Layer2.center.y - 45 ,
//                    self.Layer2.bounds.width - 160,
//                    self.Layer2.bounds.width - 160
//                )
//                self.Layer3.frame = CGRectMake(
//                    self.Layer3.center.x - 40,
//                    self.Layer3.center.y - 40,
//                    self.Layer3.bounds.width - 80,
//                    self.Layer3.bounds.width - 80
//                )
                
                //            self.instructions.text = "Breath out..."
                }, completion: nil)})
        
        //        UIView.animateWithDuration(3.5, delay: 2.0, options: [], animations: {
        //            self.Layer4.frame = CGRectMake(
        //            self.Layer4.center.x - 50,
        //            self.Layer4.center.y - 50,
        //            self.Layer4.bounds.width + 70,
        //            self.Layer4.bounds.height + 70
        //        )
        //
        //        }, completion: {(Bool) -> Void in UIView.animateWithDuration(3.5, delay: 1.0, options: [], animations: {
        //            self.Layer4.frame = CGRectMake(
        //            self.Layer4.center.x - 25,
        //            self.Layer4.center.y - 25,
        //            self.Layer4.bounds.width - 70,
        //            self.Layer4.bounds.height - 70
        //        )}, completion: nil)})
        
        
        //        UIView.animateWithDuration(3.5, delay: 2.0, options: [], animations: {
        //            self.Layer4.frame = CGRectMake(
        //                self.Layer4.center.x - 50,
        //                self.Layer4.center.y - 50,
        //                self.Layer4.bounds.width + 70,
        //                self.Layer4.bounds.height + 70
        //            )
        //
        //            //                += (self.view.bounds.width / 10)
        //
        //
        //            }, completion: {(Bool) -> Void in UIView.animateWithDuration(3.5, delay: 1.0, options: [], animations: {
        //
        //                self.Layer4.frame = CGRectMake(
        //                    self.Layer4.center.x - 25,
        //                    self.Layer4.center.y - 25,
        //                    self.Layer4.bounds.width - 70,
        //                    self.Layer4.bounds.height - 70
        //                )}, completion: nil)})
        
    }


    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        NSTimer.scheduledTimerWithTimeInterval(11.0, target: self, selector: #selector(circleViewController.orbAnimateMethod), userInfo: nil, repeats: true)
    }
}
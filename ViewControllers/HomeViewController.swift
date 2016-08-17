//
//  HomeViewController.swift
//  Repose
//
//  Created by Joseph Duran on 8/12/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var beginPressTime = CACurrentMediaTime()
    
    var oldbounds:CGRect!
    
    @IBOutlet weak var lifelineButton: UIButton!
    @IBOutlet weak var navBa: UINavigationItem!
    var drawAnimation = CABasicAnimation()
    
    @IBOutlet weak var helpButton: circleView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Helper.isInEventState(){}
        else{
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if Helper.isInEventState(){
            navBa.title = "this will pass"
            lifelineButton.setTitle("call a lifeline", forState: .Normal)
            let helpTapped = UITapGestureRecognizer(target: self, action: Selector("helpButtonTapped:"))
            helpButton.addGestureRecognizer(helpTapped)
        }
        else{
            navBa.title = "repose modules"
            lifelineButton.setTitle("configure your lifelines", forState: .Normal)
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("longPress:"))
        longPress.minimumPressDuration = 0.5
        helpButton.addGestureRecognizer(longPress)
        helpButton.userInteractionEnabled = true

        }
    }
    
    func longPress(gesture:UILongPressGestureRecognizer){
        if gesture.state == UIGestureRecognizerState.Began
        {
            self.beginPressTime = CACurrentMediaTime()
            self.helpButton.backgroundColor = UIColor.redColor()
            self.oldbounds = self.helpButton.bounds
        }
        else if gesture.state == UIGestureRecognizerState.Changed
        {
            let bounds = self.helpButton.bounds
            let deltaTime = CACurrentMediaTime() - beginPressTime
            if deltaTime > 1.5{
                self.helpButton.backgroundColor = UIColor.greenColor()
            }
            UIView.animateWithDuration(0.5, animations: {
                self.helpButton.bounds = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width + 22, height: bounds.size.height + 22)
            })
        }
        else
        {
            let deltaTime = CACurrentMediaTime() - beginPressTime
            if deltaTime > 1.5{
                self.helpButton.bounds = self.oldbounds
                self.helpButton.backgroundColor = UIColor.greenColor()
                let defaults = NSUserDefaults.standardUserDefaults()
                let currentTime = CACurrentMediaTime()
                defaults.setObject(currentTime, forKey:"eventStart")
            }
            else{
            UIView.animateWithDuration(0.5, animations: {
                self.helpButton.bounds = self.oldbounds
                self.helpButton.backgroundColor = UIColor.blueColor()
            })
                
            }
        }
    }
    
    func helpButtonTapped(sender: UITapGestureRecognizer){
        
        if self.helpButton.backgroundColor == UIColor.blueColor(){
            
        }else{
            let defaults = NSUserDefaults.standardUserDefaults()
            let eventEnd = CACurrentMediaTime()
            defaults.setDouble(eventEnd, forKey:"eventEnd")
            self.performSegueWithIdentifier("showSurvey", sender: self)
            self.helpButton.backgroundColor = UIColor.blueColor()
        }
    }


override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}



/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
}

//
//  HomeViewController.swift
//  Repose
//
//  Created by Joseph Duran on 8/12/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import CoreLocation
import UIKit
import ResearchKit

class HomeViewController: UIViewController {
    
    var beginPressTime = CACurrentMediaTime()
    
    var oldbounds:CGRect!
    
    var helpButtonHeld : Bool = false
    
    @IBOutlet weak var lifelineButton: UIButton!
    @IBOutlet weak var navBa: UINavigationItem!
    var drawAnimation = CABasicAnimation()
    
    @IBOutlet weak var helpButton: circleView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
//    let gradientLayer = CAGradientLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.helpButton.backgroundColor = UIColor.clearColor()
        helpButtonHeld = false
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasSeenConsent = defaults.boolForKey("hasSeenConsent")
        if !hasSeenConsent{
            showConsentForm()
            defaults.setBool(true, forKey:"hasSeenConsent")
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        self.helpButton.backgroundColor = UIColor.clearColor()

        if Helper.isInEventState(){
            lifelineButton.setTitle("Call a Lifeline", forState: .Normal)
            let helpTapped = UITapGestureRecognizer(target: self, action: Selector("helpButtonTapped:"))
            helpButton.addGestureRecognizer(helpTapped)
        }
        else{
            lifelineButton.setTitle("Configure Your Lifelines", forState: .Normal)
            let helpTapped = UITapGestureRecognizer(target: self, action: Selector("helpButtonTapped:"))
            helpButton.addGestureRecognizer(helpTapped)
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("longPress:"))
        longPress.minimumPressDuration = 0.5
        helpButton.addGestureRecognizer(longPress)
        helpButton.userInteractionEnabled = true
        
        }
    }
    
    func longPress(gesture:UILongPressGestureRecognizer){
//        self.helpButton.backgroundColor = UIColor.clearColor()

        if gesture.state == UIGestureRecognizerState.Began
        {
            self.beginPressTime = CACurrentMediaTime()
//            UIColor(red: 13/255, green: 151/255, blue: 255/255, alpha: 1.0).setFill()
//                    path.fill()
//            self.helpButton.backgroundColor = UIColor.redColor()
//            self.helpButton.blackColor().setStroke()
//            UIColor.stroke()

            self.oldbounds = self.helpButton.bounds


        }
        else if gesture.state == UIGestureRecognizerState.Changed
        {
            let bounds = self.helpButton.bounds
            let deltaTime = CACurrentMediaTime() - beginPressTime
            if deltaTime > 1.5{
//                self.helpButton.backgroundColor = UIColor.greenColor()
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
//                self.helpButton.backgroundColor = UIColor.redColor()
                let defaults = NSUserDefaults.standardUserDefaults()
                let currentTime = CACurrentMediaTime()
                defaults.setObject(currentTime, forKey:"eventStart")
            }
            else{
            UIView.animateWithDuration(0.5, animations: {
                self.helpButton.bounds = self.oldbounds
//                self.helpButton.
//                self.helpButton.backgroundColor = UIColor.blueColor()
            })
                
            }
        }
    }
    
    func helpButtonTapped(sender: UITapGestureRecognizer){
        
//        if self.helpButton.backgroundColor == UIColor.blueColor(){
        if helpButtonHeld == true {
        
        }else{
            let defaults = NSUserDefaults.standardUserDefaults()
            let eventEnd = CACurrentMediaTime()
            defaults.setDouble(eventEnd, forKey:"eventEnd")
            self.performSegueWithIdentifier("showSurvey", sender: self)
//            self.helpButton.backgroundColor = UIColor.blueColor()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    func showConsentForm(){
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }
    
//    func btnPushButton(supportButton: circleView)
//    {
//        supportButton.fillColor = UIColor.redColor()
//        
//    }


}

extension HomeViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

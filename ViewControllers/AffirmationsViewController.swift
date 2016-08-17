//
//  AffirmationsViewController.swift
//  Repose
//
//  Created by Joseph Duran on 8/12/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//


extension UIView {
    
    func fadeTransition(duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        self.layer.addAnimation(animation, forKey: kCATransitionFade)
    }
}


import UIKit

class AffirmationsViewController: UIViewController {
    
    //MARK: Properties
    
    
    @IBOutlet weak var affirmationContainer: UILabel!
    
    let affirmationDisplayInterval : Double = 7  //seconds
    
    var index : Int = 1     // Indexed at one, because the zeroth-indexed affirmation will be populated on viewDidLoad
    
    var myArray:[String] = ["0", "1", "2", "3", "4"]
    //var myArray:[String] = ["1", "2", "3", "4", "5"]
    
    
    func scrambleArray() {
        var source = self.myArray
        var target: [String] = []
        var i : Int = 0
        var j : Int
        while source.count > 0 {
            j = Int(arc4random_uniform(UInt32(source.count)))
            target.insert(source[j], atIndex: i )
            source.removeAtIndex(j)
            i += 1
        }
        return self.myArray = target
    }
    
    
    func textTransition() {
    print(index)
    
        let pictureString:String = self.myArray[index]
        self.affirmationContainer.fadeTransition(1.0)
        self.affirmationContainer.text = pictureString
        index = (index < myArray.count-1) ? index+1 : 0
    }
    
    func textTransitionLeft() {
        print(index)
            switch index {
    case 0:
        let pictureString:String = self.myArray[myArray.count-1]
        self.affirmationContainer.fadeTransition(1.0)
        self.affirmationContainer.text = pictureString
        print("before change")
        print(index)
        index = myArray.count-1
        print(index)
    default:
        let pictureString:String = self.myArray[index-1]
        self.affirmationContainer.fadeTransition(1.0)
        self.affirmationContainer.text = pictureString
        index -= 1
}
//        let pictureString:String = self.myArray[index - 2]
//        self.affirmationContainer.fadeTransition(1.0)
//        self.affirmationContainer.text = pictureString
//        index = (index < 1) ? 0 : index - 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrambleArray()
        self.affirmationContainer.text = self.myArray[0]
        // Do any additional setup after loading the view.
        
        //MARK: Swipe Logic
        let swipeRight = UISwipeGestureRecognizer(target: self, action: Selector("respond:"))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: Selector("respond:"))
        swipeLeft.direction = .Left
        view.addGestureRecognizer(swipeLeft)
    }
    
    func respond(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("RIGHT")
                textTransition()
            case UISwipeGestureRecognizerDirection.Left:
                print("LEFT")
                textTransitionLeft()
            default:
                break
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        NSTimer.scheduledTimerWithTimeInterval(affirmationDisplayInterval, target: self, selector: #selector(AffirmationsViewController.textTransition), userInfo: nil, repeats: true)
        
//        print("end viewDidAppear")
    }
    
    
}

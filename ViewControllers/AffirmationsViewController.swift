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
    

    var myArray:[String] = ["All is safe in my world right now.", "Breathing deeply reminds me that all is well.", "I will be alright.", "Even though anxiety is uncomfortable, I am safe.", "I have had this experience before and I know that I am safe.", "I don't need to fight my feelings.  They will pass.", "I accept myself with contentment and gentleness.", "I'm going to treat myself gently and continue on with my work.", "As I exhale, I think to myself \"Relax...\"", "I can feel the sensation of my breath and remember that I am alive.", "I am strong.  These feelings are just an illusion.", "The feelings will ease bit by bit.  I'm getting a break soon.", "I can take deep, calming breaths until this passes.", "Anxiety means I'm alive.", "I know this will pass.", "I breath deeply.", "I remind myself that it's okay to feel this.  I don't have to like these sensations.  It's natural to not want them around.", "In spite of my anxiety, I can still live my life.", "I'm still alive.  The world is still turning.  Zaki still doesn't know how to put photos on Trello."]
    //var myArray:[String] = ["1", "2", "3", "4", "5"]
    
    var affTimer = NSTimer()
    
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
        
        self.view.backgroundColor = UIColor(red:0.27, green:0.56, blue:0.89, alpha:1.0)
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
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        timer.invalidate()
        
    }
    
    
}

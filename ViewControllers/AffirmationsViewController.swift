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
    
    var myArray:[String] = ["Anxiety Quote 1", "Quote number 2", "Quote 3, quote3, apple, banana, orange", "Green, blue, red, yellow, brown, pink, white, grey. Green, blue, red, yellow, brown, pink, white, grey. Green, blue, red, yellow, brown, pink, white, grey.", "One two three four five six seven eight nine ten."]
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
        let pictureString:String = self.myArray[index]
        self.affirmationContainer.fadeTransition(1.0)
        self.affirmationContainer.text = pictureString
        index = (index < myArray.count-1) ? index+1 : 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrambleArray()
        self.affirmationContainer.text = self.myArray[0]
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        NSTimer.scheduledTimerWithTimeInterval(affirmationDisplayInterval, target: self, selector: #selector(AffirmationsViewController.textTransition), userInfo: nil, repeats: true)
        
        print("end viewDidAppear")
    }
    
    
}

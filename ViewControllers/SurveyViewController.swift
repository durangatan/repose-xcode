//
//  ViewController.swift
//  Camelot
//
//  Created by Joseph Duran on 8/14/16.
//  Copyright © 2016 Repo Men. All rights reserved.


import UIKit
import ResearchKit
import Alamofire
class SurveyViewController: UIViewController {
    
    var resultArray = Array([])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        presentViewController(taskViewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getBearerToken()->String{
        let defaults = NSUserDefaults.standardUserDefaults()
        if let bearerToken = defaults.stringForKey("bearerToken")
        {
            return bearerToken
        }
        else{
            return ""
        }
    }
}

extension SurveyViewController : ORKTaskViewControllerDelegate {
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
        if let results = taskViewController.result.results {
            for result in results {
                let stepId = result.identifier
                let resultObject = result.valueForKeyPath("results")
                let answerData = resultObject!.valueForKeyPath("answer")
                if answerData!.count != 0{
                    resultArray.append([stepId:answerData!.objectAtIndex(0)])
                }
            }
            print("\(resultArray)")
            let defaults = NSUserDefaults.standardUserDefaults()
            let token = getBearerToken()
            let startTime = defaults.doubleForKey("eventStart")
            let endTime = defaults.doubleForKey("eventEnd")
            let event = [startTime, endTime]
            Alamofire.request(.POST, "https://repose.herokuapp.com/api/v1/events", parameters:["survey":resultArray, "bearer_token":token, "event":event,])
                .responseJSON { response in
                    switch response.result{
                    case .Success:
                        let alertView = UIAlertController(title: "Success!",
                            message: "Thanks", preferredStyle:.Alert)
                        let okAction = UIAlertAction(title: "dismiss!", style: .Default, handler: nil)
                        alertView.addAction(okAction)
                        self.presentViewController(alertView, animated: true, completion: nil)
                    case .Failure:
                        let alertView = UIAlertController(title: "Sorry",
                            message: "invalid email or password." as String, preferredStyle:.Alert)
                        let okAction = UIAlertAction(title: "dismiss", style: .Default, handler: nil)
                        alertView.addAction(okAction)
                        self.presentViewController(alertView, animated: true, completion: nil)
                    }
                }
            defaults.setValue(nil, forKey:"eventStart")
            }
        }
}
//
//  ViewController.swift
//  Camelot
//
//  Created by Joseph Duran on 8/14/16.
//  Copyright © 2016 Repo Men. All rights reserved.


import UIKit
import ResearchKit
import Alamofire
import CoreLocation

class SurveyViewController: UIViewController,CLLocationManagerDelegate {
    
    var resultArray = Array([])
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        let taskViewController = ORKTaskViewController(task: SurveyTask, taskRunUUID: nil)
        taskViewController.delegate = self
        self.locationManager.delegate = self
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
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
            self.locationManager.requestLocation()
            let latitude = NSUserDefaults.standardUserDefaults().doubleForKey("eventLatitude")
            let longitude = NSUserDefaults.standardUserDefaults().doubleForKey("eventLongitude")
            let coordinate = [latitude, longitude]
            
            Alamofire.request(.POST, "https://repose.herokuapp.com/api/v1/events", parameters:["survey":resultArray, "bearer_token":token, "event":event, "coordinate":coordinate])
                .responseJSON { response in
                    switch response.result{
                    case .Success:
                        print("saved")
                    case .Failure:
                        print("failed to save")
                    }
                }
            defaults.setValue(nil, forKey:"eventStart")
            }
        }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        let latitude = location!.coordinate.latitude
        let longitude = location!.coordinate.longitude
        NSUserDefaults.standardUserDefaults().setValue(latitude, forKey: "eventLatitude")
        NSUserDefaults.standardUserDefaults().setValue(longitude, forKey: "eventLongitude")
        self.locationManager.stopUpdatingLocation()

    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError)
    {
        print("Errors: " + error.localizedDescription)
    }

}
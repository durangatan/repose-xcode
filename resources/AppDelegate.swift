//
//  AppDelegate.swift
//  Repose
//
//  Created by Joseph Duran on 8/11/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import UIKit
import Contacts
import ResearchKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var contactStore = CNContactStore()
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        clearStoredEvent()
        UILabel.appearance().font = UIFont(name: "HelveticaNeue", size: 22.0)
        UINavigationBar.appearance().tintColor =  UIColor(red:0.27, green:0.56, blue:0.89, alpha:1.0)
        UIView.appearanceWhenContainedInInstancesOfClasses([ORKTaskViewController.self])
        return true
    }
    
    func showMessage(message: String) {
        let alertController = UIAlertController(title: "Lifelines", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let dismissAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
        }
        
        alertController.addAction(dismissAction)
        
        let pushedViewControllers = (self.window?.rootViewController as! UINavigationController).viewControllers
        let presentedViewController = pushedViewControllers[pushedViewControllers.count - 1]
        
        presentedViewController.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func requestForAccess(completionHandler: (accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatusForEntityType(CNEntityType.Contacts)
        
        switch authorizationStatus {
        case .Authorized:
            completionHandler(accessGranted: true)
            
        case .Denied, .NotDetermined:
            self.contactStore.requestAccessForEntityType(CNEntityType.Contacts, completionHandler: { (access, accessError) -> Void in
                if access {
                    completionHandler(accessGranted: access)
                }
                else {
                    if authorizationStatus == CNAuthorizationStatus.Denied {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let message = "\(accessError!.localizedDescription)\n\nPlease allow the app to access your contacts through the Settings."
                            self.showMessage(message)
                        })
                    }
                }
            })
            
        default:
            completionHandler(accessGranted: false)
        }
    }
    
        func applicationWillTerminate(application: UIApplication) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(nil, forKey: "startTime")
        defaults.setValue(nil, forKey: "endTime")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func clearStoredEvent(){
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "startTime")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "endTime")
    }
    
}


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
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let bearerToken = NSUserDefaults.standardUserDefaults().stringForKey("bearerToken")
        UIView.appearanceWhenContainedInInstancesOfClasses([ORKTaskViewController.self]).backgroundColor = UIColor(red:0.27, green:0.56, blue:0.89, alpha:1.0)
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "startTime")
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "endTime")
        UILabel.appearance().font = UIFont(name: "HelveticaNeue", size: 22.0)
        UINavigationBar.appearance().tintColor =  UIColor(red:0.27, green:0.56, blue:0.89, alpha:1.0)
        UIView.appearanceWhenContainedInInstancesOfClasses([ORKTaskViewController.self])

  
//                UIView.appearance().backgroundColor = UIColor.orangeColor()

        
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
    
    
        func applicationWillResignActive(application: UIApplication) {
            // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
            // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        }
        
        func applicationDidEnterBackground(application: UIApplication) {
            // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
            // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        }
        
        func applicationWillEnterForeground(application: UIApplication) {
            // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        }
        
        func applicationDidBecomeActive(application: UIApplication) {
            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        }
        
        func applicationWillTerminate(application: UIApplication) {
           let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setValue(nil, forKey: "startTime")
            defaults.setValue(nil, forKey: "endTime")
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
        

}


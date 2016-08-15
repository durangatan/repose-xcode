//
//  ProfileViewController.swift
//  Repose
//
//  Created by Joseph Duran on 8/12/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: Attributes
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var profileWebView: UIWebView!
    
    //MARK: Actions
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: "https://repose.herokuapp.com");
        let requestObj = NSURLRequest(URL: url!);
        profileWebView.loadRequest(requestObj);
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
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

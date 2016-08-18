//
//  LoginViewController.swift
//  Repose
//
//  Created by Joseph Duran on 8/12/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import UIKit
import Alamofire
import ResearchKit

class LoginViewController: UIViewController{
    
    // MARK: Properties
    
    let createLoginButtonTag = 0
    let loginButtonTag = 1
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var createInfoLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    

    
    func checkRegistrationStatus(email:String, password:String)->Bool{
        Alamofire.request(.POST, "https://repose.herokuapp.com/api/v1/users", parameters:["user":["email":email, "password": password]])
            .responseJSON { response in
                switch response.result{
                case .Success:
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(response.data!, forKey: "bearerToken")
                    defaults.setBool(true, forKey:"hasReposeAccount")
                    self.performSegueWithIdentifier("dismissLogin", sender: self)
                    
                case .Failure:
                    let alertView = UIAlertController(title: "Registration Problem",
                        message: "invalid email or password." as String, preferredStyle:.Alert)
                    let okAction = UIAlertAction(title: "retry!", style: .Default, handler: nil)
                    alertView.addAction(okAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
        }
        return true
    }
    
    
    // ask the Repose server if the given credentials are valid.
    func checkLogin(email: String, password :String) -> Void{
        Alamofire.request(.POST, "https://repose.herokuapp.com/api/v1/sessions", parameters: ["session":["email": email,"password": password]])
            .responseJSON { response in
                switch response.result{
                case .Success:
                    let myToken = response.result.value!["bearer_token"]!
                    let defaults = NSUserDefaults.standardUserDefaults()
                    defaults.setObject(myToken, forKey: "bearerToken")
                    self.performSegueWithIdentifier("dismissLogin", sender: self)
                case .Failure:
                    let alertView = UIAlertController(title: "Registration Problem",
                        message: "invalid email or password." as String, preferredStyle:.Alert)
                    let okAction = UIAlertAction(title: "Sorry!", style: .Default, handler: nil)
                    alertView.addAction(okAction)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // check to see if the user has a login
        let hasLogin = NSUserDefaults.standardUserDefaults().valueForKey("hasReposeAccount") as? Bool
        // if they do, the button is a log in button
        if hasLogin == true {
            loginButton.setTitle("Login", forState: UIControlState.Normal)
            loginButton.tag = loginButtonTag
            createInfoLabel.hidden = true
        } else {
            // if they don't, their button is a create button
            
            loginButton.setTitle("Create", forState: UIControlState.Normal)
            loginButton.tag = createLoginButtonTag
            createInfoLabel.hidden = false
        }
        
        // 3 Load the user's email if they have one
        if let storedEmail = NSUserDefaults.standardUserDefaults().valueForKey("email") as? String {
            emailTextField.text = storedEmail as String
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    // Ask the Repose server to authenticate login credentials. If it can,
    // store the bearer token in NSUserDefaults.
    // If it can't, display the error message.
    @IBAction func loginAction(sender: AnyObject) {
        
        // Display errors if users don't provide any information
        if (emailTextField.text == "" || passwordTextField.text == "") {
            let alertView = UIAlertController(title: "Login Problem",
                                              message: "Wrong username or password." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Blank Fields", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        // resign focus from email and password fields
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        // if the sender is the registration button
        if sender.tag == createLoginButtonTag {
            checkRegistrationStatus(emailTextField.text!, password: passwordTextField.text!)
        } else if sender.tag == loginButtonTag {
            checkLogin(emailTextField.text!, password: passwordTextField.text!)
        }
    }
}

extension LoginViewController : ORKTaskViewControllerDelegate {
    
    func taskViewController(taskViewController: ORKTaskViewController, didFinishWithReason reason: ORKTaskViewControllerFinishReason, error: NSError?) {
        taskViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
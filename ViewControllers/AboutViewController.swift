//
//  AboutViewController.swift
//  Repose
//
//  Created by Joseph Duran on 8/17/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import UIKit


class AboutViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var web: UIWebView!
    
    var indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        indicator.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
        indicator.center = view.center
        view.addSubview(indicator)
        indicator.bringSubviewToFront(view)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let url = NSURL(string: "https://repose.herokuapp.com");
        let requestObj = NSURLRequest(URL: url!);
        web.loadRequest(requestObj);
        requestObj
    }
    
    func webViewDidStartLoad(webView: UIWebView){
        indicator.startAnimating()
        
    }
    public func webViewDidFinishLoad(webView: UIWebView){
        indicator.stopAnimating()
    }
}

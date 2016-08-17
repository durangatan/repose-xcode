//
//  Eventable.swift
//  Repose
//
//  Created by Joseph Duran on 8/17/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import Foundation

class Helper{
    static func isInEventState()->Bool{
        let defaults = NSUserDefaults.standardUserDefaults()
        let eventStart = defaults.objectForKey("eventStart")
        if eventStart != nil{
            return true
        }else{
            return false
        }
    }
}
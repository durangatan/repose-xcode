//
//  Lifeline.swift
//  
//
//  Created by Jane Appleseed on 5/26/15.
//  Copyright © 2015 Apple Inc. All rights reserved.
//  See LICENSE.txt for this sample’s licensing information.
//

import UIKit

class Lifeline: NSObject, NSCoding {
    // MARK: Properties
    
    var first: String
    var last: String
    var phone: String
    var startTime: Int?
    var endTime: Int?
    
    // MARK: Archiving Paths
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("lifelines")
    
    // MARK: Types
    
    struct PropertyKey {
        static let firstNameKey = "firstName"
        static let lastNameKey = "lastName"
        static let phoneKey = "phone"
        static let startTimeKey = "startTime"
        static let endTimeKey = "endTime"
    }

    // MARK: Initialization
    
    init?(first: String, last: String, phone: String, startTime: Int?, endTime: Int?) {
        // Initialize stored properties.
        self.first = first
        self.last = last
        self.phone = phone
        self.startTime = startTime
        self.endTime = endTime
        
        
        super.init()
        
        // Initialization should fail if there is no phone number.
        if phone == "" {
            return nil
        }
    }
    
    // MARK: Methods
    func isAvailableNow()-> Bool{
        
        return isPastStartHour() && isBeforeEndHour()
    }
    
    func isPastStartHour()->Bool{
        let now = NSDate()
        let cal = NSCalendar.currentCalendar()
        let components = cal.components([.Hour], fromDate:now)
        
        return self.startTime <= components.hour
    }
    
    func isBeforeEndHour()->Bool{
        let now = NSDate()
        let cal = NSCalendar.currentCalendar()
        let components = cal.components([.Hour], fromDate:now)
        return self.endTime >= components.hour
    }
    
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(first, forKey: PropertyKey.firstNameKey)
        aCoder.encodeObject(last, forKey: PropertyKey.lastNameKey)
        aCoder.encodeObject(phone, forKey: PropertyKey.phoneKey)
        aCoder.encodeObject(startTime, forKey: PropertyKey.startTimeKey)
        aCoder.encodeObject(endTime, forKey: PropertyKey.endTimeKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let first = aDecoder.decodeObjectForKey(PropertyKey.firstNameKey) as! String
        let last = aDecoder.decodeObjectForKey(PropertyKey.lastNameKey) as! String
        let phone = aDecoder.decodeObjectForKey(PropertyKey.phoneKey) as! String
        let startTime = aDecoder.decodeObjectForKey(PropertyKey.startTimeKey) as? Int
        let endTime = aDecoder.decodeObjectForKey(PropertyKey.endTimeKey) as? Int        
        // Must call designated initializer.
        self.init(first: first, last: last, phone: phone, startTime: startTime, endTime: endTime)
    }

}
//
//  ListItem.swift
//  SafetyCheckList
//
//  Created by Apprentice on 8/13/16.
//  Copyright © 2016 doug and zaki. All rights reserved.
//

import UIKit

class ListItem: NSObject, NSCoding {
    
    // A text description of this item.
    var text: String
    
    // A Boolean value that determines the completed state of this item.
    var completed: Bool
    

    // Returns a ListItem initialized with the given text and default completed value.
    init(text: String) {
        self.text = text
        self.completed = false
        super.init()
    }
    
    struct PropertyKey {
        static let textKey = "text"
 
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: PropertyKey.textKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObjectForKey(PropertyKey.textKey) as! String

        
        // Must call designated initializer.
        self.init(text: text)
    }

    // MARK: Archiving Paths
     
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("listItems")
}

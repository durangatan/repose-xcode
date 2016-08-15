//
//  ListItem.swift
//  SafetyCheckList
//
//  Created by Apprentice on 8/13/16.
//  Copyright © 2016 doug and zaki. All rights reserved.
//

import UIKit

class ListItem: NSObject {
    
    // A text description of this item.
    var text: String
    
    // A Boolean value that determines the completed state of this item.
    var completed: Bool
    
    // Returns a ListItem initialized with the given text and default completed value.
    init(text: String) {
        self.text = text
        self.completed = false
    }
    
    
}

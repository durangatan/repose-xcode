//
//  todo.swift
//  
//
//  Created by Joseph Duran on 8/17/16.
//
//

import UIKit

class Todo:NSObject, NSCoding {
    // MARK: Properties
    
    var text: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("todos")

    
    //MARK: Initialization
    
    init(text:string){
        self.text = text
        super.init()

    }
    
    //MARK: Types
    struct PropertyKey{
        static let textKey = "text"
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder:NSCoder){
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObjectForKey(PropertyKey.textKey) as! String
        self.init(text:text)
    }
    
    
}

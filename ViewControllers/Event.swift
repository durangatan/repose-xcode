//
//  Artwork.swift
//  HonoluluArt
//
//  Created by Joseph Duran on 8/16/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import Foundation

import MapKit

class Event: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let severity: Int?
    let sleep_quality: Int?
    let comments: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, comments: String, coordinate: CLLocationCoordinate2D, severity:Int?, sleep_quality:Int?) {
        self.title = title
        self.locationName = locationName
        self.severity = severity
        self.sleep_quality = sleep_quality
        self.comments = comments
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
}
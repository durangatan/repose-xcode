//
//  ViewController.swift
//  HonoluluArt
//
//  Created by Joseph Duran on 8/16/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
class EventMapViewController: UIViewController{
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
    let event = Event(title: "King David Kalakaua",
                      locationName: "Waikiki Gateway Park",
                      comments: "Sculpture",
                      coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661),
                      severity: 5,
                      sleep_quality: 1)
    let anotherEvent = Event(title: "This part",
                             locationName: "chicago",
                             comments: "comment",
                             coordinate: CLLocationCoordinate2D(latitude: 21.283920, longitude: -157.831),
                             severity:4,
                             sleep_quality:1)
    
    let user = NSDictionary()
    
    let regionRadius: CLLocationDistance = 1000
    
    let initialLocation = CLLocation(latitude: 41.878114, longitude: -87.629798)
    
    @IBOutlet weak var mapView: MKMapView!
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // set initial location in Honolulu
        
        
        centerMapOnLocation(initialLocation)
        let bearerToken = "K0NNh8mVDKooi6XWziiPmPpQ1ezNlfO5OxXRdzF9cKZEgYj2iI/DjMMKQHWR75hSqtKGD5rPZGhbbiu0apxi8Q=="
        mapView.delegate = self
        
        // show event on map
        Alamofire.request(.GET, "https://repose.herokuapp.com/api/v1/users/36", parameters: ["bearerToken":bearerToken])
            .responseJSON { response in
                switch response.result{
                case .Success(let JSON):
                    let user = JSON as! NSDictionary
                    let events = user.valueForKey("events") as! NSArray
                    
                    for userEvent in events {
                        if let eventHash = userEvent as? NSDictionary{
                            let long = eventHash.valueForKey("longitude") as! String
                            let longVal = Double(long)
                            let lat = eventHash.valueForKey("latitude") as! String
                            let latVal = Double(lat)
                            let mapEvent = Event( title:"Event",
                                locationName: "location",
                                comments: "what a great event",
                                coordinate: CLLocationCoordinate2D(latitude: latVal!, longitude: longVal!),
                                severity: 2,
                                sleep_quality: 1)
                            self.mapView.addAnnotation(mapEvent)
                        }
                        
                    }
                case .Failure:
                    print("no dice")
                }
        }
        
        
    }
    
    
    
    
}


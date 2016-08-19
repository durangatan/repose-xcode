//
//  ProfileViewController.swift
//  Repose
//
//  Created by Joseph Duran on 8/12/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import UIKit

import ResearchKit
import Alamofire
class ProfileViewController: UIViewController, ORKGraphChartViewDataSource, ORKGraphChartViewDelegate {
    
    //MARK: Attributes
    @IBOutlet weak var lineChart: ORKLineGraphChartView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let bearerToken = "K0NNh8mVDKooi6XWziiPmPpQ1ezNlfO5OxXRdzF9cKZEgYj2iI/DjMMKQHWR75hSqtKGD5rPZGhbbiu0apxi8Q=="
    var sleepPoints :[ORKRangedPoint] = []
    var severityPoints: [ORKRangedPoint] = []
    var plotPoints = [
        [
            ORKRangedPoint(value: 200),
            ORKRangedPoint(value: 450),
            ORKRangedPoint(value: 500),
            ORKRangedPoint(value: 250),
            ORKRangedPoint(value: 300),
            ORKRangedPoint(value: 600),
            ORKRangedPoint(value: 300),
        ],
        [
            ORKRangedPoint(value: 100),
            ORKRangedPoint(value: 350),
            ORKRangedPoint(value: 400),
            ORKRangedPoint(value: 150),
            ORKRangedPoint(value: 200),
            ORKRangedPoint(value: 500),
            ORKRangedPoint(value: 400),
        ]
    ]
    
    //MARK: Actions
    
    func numberOfDivisionsInXAxisForGraphChartView(graphChartView: ORKGraphChartView) -> Int {
    return 1
    }
    
//    func graphChartView(graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
//    return ""
//    }
    
    func graphChartView(graphChartView: ORKGraphChartView, pointForPointIndex pointIndex: Int, plotIndex: Int) -> ORKRangedPoint {
        return plotPoints[plotIndex][pointIndex]
    }
    
    func graphChartView(graphChartView: ORKGraphChartView, numberOfPointsForPlotIndex plotIndex: Int) -> Int {
        return plotPoints[plotIndex].count
    }
    
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
            do {
                return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Connect the line graph view object to a data source
        lineChart.dataSource = self
        
        // Optional custom configuration
        lineChart.showsHorizontalReferenceLines = true
        lineChart.showsVerticalReferenceLines = true
        lineChart.axisColor = UIColor.whiteColor()
        lineChart.verticalAxisTitleColor = UIColor.orangeColor()
        lineChart.showsHorizontalReferenceLines = true
        lineChart.showsVerticalReferenceLines = true
        lineChart.scrubberLineColor = UIColor.redColor()
        Alamofire.request(.GET, "https://repose.herokuapp.com/api/v1/users/36/events", parameters: ["bearerToken":bearerToken])
            .responseJSON { response in
                switch response.result{
                case .Success:
                    print(response)
                case .Failure:
                    print("failed to download events")
                }
        }
        
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
}

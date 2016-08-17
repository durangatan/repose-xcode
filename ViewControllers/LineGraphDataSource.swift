//
//  LineGraphDataSource.swift
//  Repose
//
//  Created by Joseph Duran on 8/16/16.
//  Copyright © 2016 Repo Men. All rights reserved.
//

import Foundation
import ResearchKit
import Alamofire

class LineGraphDataSource: NSObject, ORKGraphChartViewDataSource {
        
    var plotPoints:[[ORKRangedPoint]] = []

    // Required methods
    

    
    // Optional methods
    
    // Returns the number of points to the graph chart view
    func numberOfPlotsInGraphChartView(graphChartView: ORKGraphChartView) -> Int {
        return plotPoints.count
    }
    
    // Sets the maximum value on the y-axis
    func maximumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 1000
    }
    
    // Sets the minimum value on the y-axis
    func minimumValueForGraphChartView(graphChartView: ORKGraphChartView) -> CGFloat {
        return 0
    }
    
    // Provides titles for x-axis
    func graphChartView(graphChartView: ORKGraphChartView, titleForXAxisAtPointIndex pointIndex: Int) -> String? {
        switch pointIndex {
        case 0:
            return "Mon"
        case 1:
            return "Tue"
        case 2:
            return "Wed"
        case 3:
            return "Thu"
        case 4:
            return "Fri"
        case 5:
            return "Sat"
        case 6:
            return "Sun"
        default:
            return "Day \(pointIndex + 1)"
        }
    }
    
    // Returns the color for the given plot index
    func graphChartView(graphChartView: ORKGraphChartView, colorForPlotIndex plotIndex: Int) -> UIColor {
        if plotIndex == 0 {
            return UIColor.purpleColor()
        }
        return UIColor.redColor()
    }
}
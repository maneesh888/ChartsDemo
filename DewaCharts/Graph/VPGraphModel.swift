//
//  Models.swift
//  DewaCharts
//
//  Created by Maneesh on 04/03/2024.
//

import SwiftUI


import SwiftUI
import Charts


enum DWChartType: String, CaseIterable {
    case bar, line
    var typeIcon: String {
        switch self {
        case .bar:
            return "chart.bar.xaxis.ascending"
        case .line:
            return "chart.xyaxis.line"
       
        }
    }
}

enum DWChartPeriod: String, CaseIterable {
    case yearly, monthly
    var title: String{
        switch self {
        case .monthly:
            return "Daily"
        case .yearly:
            return "Monthly"
        }
    }
}

class DWChartConfig: Codable {
    
    enum ConstumptionType: String, CaseIterable, Codable {
        case water, electricity
        
        var unitLabel:String {
            switch self {
                
            case .water:
                return "IG"
            case .electricity:
                return "kWh"
            }
        }
        
        var title:String {
            switch self {
                
            case .water:
                return "Water Conception"
            case .electricity:
                return "Electricity Conception"
            }
        }
    }
    
  
    
    var consuptionType: ConstumptionType
    var showLegend: Bool = false
    
    
    init(consuptionType: ConstumptionType, showLegend: Bool) {
        self.consuptionType = consuptionType
        self.showLegend = showLegend
    }
    
    var _monthlyData: [DWGraphData] = monthlyData
    var _yearlyData: [DWGraphData] = yearlyData
    
    func setYearly(_ data: [DWGraphData]) {
        self._yearlyData = data
    }
    
    func setMonthly(_ data: [DWGraphData]) {
        self._monthlyData = data
    }
    
    
}

struct DWGraphData: Identifiable, Codable {

    var id = UUID()
    let title: String
    let color: GraphItemColor
    var points: [DWGraphPoint]
    
    struct DWGraphPoint: Codable {
        
        let time: TimeInterval
        let value: Double
    }
}




enum GraphItemColor: String, Codable {
    case plot1, plot2, plot3
    
    var swiftUIColor: Color {
        switch self {
            
        case .plot1:
            return .primaryButtonBgColor
        case .plot2:
            return .dewa
        case .plot3:
            return .nakheel
        }
    }
}



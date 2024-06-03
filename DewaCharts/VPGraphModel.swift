//
//  Models.swift
//  DewaCharts
//
//  Created by Maneesh on 04/03/2024.
//

import SwiftUI


import SwiftUI
import Charts


class DWChartConfig: ObservableObject {
    
    enum ConstumptionType: String, CaseIterable {
        case water, electricity
        
        var unitLabel:String {
            switch self {
                
            case .water:
                return "IG"
            case .electricity:
                return "kWh"
            }
        }
    }
    
    enum GraphType: String, CaseIterable {
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
    
    enum Period: String, CaseIterable {
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
    
    @Published var consuptionType: ConstumptionType
    @Published var graphType: GraphType
    var data: [DWGraphData] = []
    var period: Period
    var showLegend: Bool = false
    
    init(consuptionType: ConstumptionType, graphType: GraphType, data: [DWGraphData], period: Period, showLegend: Bool) {
        self.consuptionType = consuptionType
        self.graphType = graphType
        self.data = data
        self.period = period
        self.showLegend = showLegend
    }
}

struct DWGraphData: Identifiable {

    var id = UUID()
    let title: String
    let color: GraphItemColor
    var points: [DWGraphPoint]
    
    struct DWGraphPoint {
        
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
            return .waterBgColor
        case .plot3:
            return .slabYellow
        }
    }
}



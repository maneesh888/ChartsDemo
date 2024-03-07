//
//  Models.swift
//  DewaCharts
//
//  Created by Maneesh on 04/03/2024.
//

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
        
        var icon:String {
            switch self {
            case .water:
                return "💙"
            case .electricity:
                return "💚"
            }
        }
        
    }
    
    enum Period {
        case monthly, yearly
    }
    
    @Published var consuptionType: ConstumptionType
    var data: [DWGraphData] = []
    var period: Period
    var showLegend: Bool = false
    
    init(consuptionType: ConstumptionType, data: [DWGraphData], period: Period, showLegend: Bool) {
        self.consuptionType = consuptionType
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
            return .yellow
        case .plot2:
            return .blue
        case .plot3:
            return .green
        }
    }
}




//extension Array where Element == DWGraphPoint {
//    func toDateValuePairs() -> [(time: Date, value: Double)] {
//        return self.map { (Date(timeIntervalSince1970: $0.time), $0.value) }
//    }
//}

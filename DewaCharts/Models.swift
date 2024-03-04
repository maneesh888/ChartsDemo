//
//  Models.swift
//  DewaCharts
//
//  Created by Maneesh on 04/03/2024.
//

import SwiftUI


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

    let id = UUID()
    let title: String // 2024
    let color: Color
    var points: [(time: Date, value: Double)]
    
}


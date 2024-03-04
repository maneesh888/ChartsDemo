//
//  VPMixedChartView.swift
//  DewaCharts
//
//  Created by Maneesh on 28/02/2024.
//

import SwiftUI






struct VPMixedChartView: View {
    
    enum ContentType {
        case bar(Calendar.Component), line(Calendar.Component)
    }
    
    @ObservedObject var config:DWChartConfig
    
    var data: [DWGraphData] {
        config.data
    }
    
    var strideBy: Calendar.Component {
        switch config.period {
        case .monthly: return .day
        case .yearly: return .month
        }
    }
    
    var body: some View {
        
        
        VStack (spacing:10) {
            
            switch config.consuptionType {
            case .water:
                HStack {
                    Text(config.consuptionType.unitLabel)
                    Spacer()
                    Picker("", selection: $config.consuptionType) {
                        ForEach(DWChartConfig.ConstumptionType.allCases, id: \.self) {
                            Text($0.icon)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 100)
                }
                .frame(maxWidth: .infinity)
                
                VPLineChartView(timeStrideBy: strideBy ,data: data.combineYear, showLegend: config.showLegend)
            case .electricity:
                HStack {
                    Text(config.consuptionType.unitLabel)
                    Spacer()
                    Picker("", selection: $config.consuptionType) {
                        ForEach(DWChartConfig.ConstumptionType.allCases, id: \.self) {
                            Text($0.icon)
                        }
                    }
                    .pickerStyle(.segmented)
                    .frame(maxWidth: 100)
                }
                .frame(maxWidth: .infinity)
                VPBarMarkView(timeStrideBy: strideBy,
                              data:data.combineYear, showLegend: config.showLegend)
            }
        }.padding(5)
    }
}

#Preview {
    VPMixedChartView(config: config)
}

extension [DWGraphData] {
    var combineYear: [DWGraphData] {
            let currentYear = Calendar.current.component(.year, from: Date())
            var newData: [DWGraphData] = []
            
            for var graphData in self {
                var updatedPoints: [(Date, Double)] = []
                
                // Create a dictionary to store existing points by month
                var existingPointsByMonth: [Int: Double] = [:]
                for (date, value) in graphData.points {
                    let month = Calendar.current.component(.month, from: date)
                    existingPointsByMonth[month] = value
                }
                
                // Iterate through each month and fill in missing months with zero values
                for month in 1...12 {
                    let dateComponents = DateComponents(year: currentYear, month: month, day: 1)
                    if let date = Calendar.current.date(from: dateComponents) {
                        let value = existingPointsByMonth[month] ?? 0.0
                        
                        updatedPoints.append((date, value))
                    }
                }
                
                graphData.points = updatedPoints
                newData.append(graphData)
            }
            
            return newData
        }
    
    var combineMonth: [DWGraphData] {
        []
    }
    
}

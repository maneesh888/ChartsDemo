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
                
                VPLineChartView(period:config.period ,data: config.period == .monthly ? data.combineMonth : data.combineYear, showLegend: config.showLegend)
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
                VPBarMarkView(period: config.period,
                              data:config.period == .monthly ? data.combineMonth : data.combineYear, showLegend: config.showLegend)
            }
        }.padding(5)
    }
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
    
   
    
    
    var highestRoundedPointCeilingValue: Double? {
        // Initialize the maximum value with the smallest possible value
        var maxValue: Double = -.greatestFiniteMagnitude
        
        // Find the highest value among all points
        for graphData in self {
            for (_, value) in graphData.points {
                maxValue = Swift.max(maxValue, value)
            }
        }
        
        // Calculate the ceiling value
        guard maxValue != -.greatestFiniteMagnitude else {
            return nil // Return nil if no points exist
        }
        
        // Calculate the magnitude of the rounding factor based on the number of digits in the maximum value
            let magnitude = pow(10.0, floor(log10(maxValue)))
            let nearestMultiple = ceil(maxValue / magnitude) * magnitude
            return nearestMultiple
    }
    
    
    var combineMonth: [DWGraphData] {
        
        guard self.count > 1 else { return self }
        
        var newData: [DWGraphData] = []
        
        // Find the most frequent month
        var selectedMonth = 1
        var selectedYear = 2000
        var maxDaysInMonth = 0
        
        for graphData in self {
            for point in graphData.points {
                let daysInMonth = Calendar.current.range(of: .day, in: .month, for: point.0)?.count ?? 0
                
                
                if daysInMonth > maxDaysInMonth {
                    selectedMonth = Calendar.current.component(.month, from: point.0)
                    selectedYear = Calendar.current.component(.year, from: point.0)
                    maxDaysInMonth = daysInMonth
                    
                    if daysInMonth == 31 {
                        break // No need to continue checking other points
                    }
                }
            }
        }
        
        // Update all points to have the selected month
        for graphData in self {
            var updatedPoints: [(Date, Double)] = []
            for point in graphData.points {
                let originalDate = point.0
                var dateComponents = Calendar.current.dateComponents([ .day], from: originalDate)
                dateComponents.month = selectedMonth
                dateComponents.year = selectedYear
                let updatedDate = Calendar.current.date(from: dateComponents)!
                updatedPoints.append((updatedDate, point.1))
            }
            
            // Update the points of the graph data object
            newData.append(DWGraphData(title: graphData.title, color: graphData.color, points: updatedPoints))
        }
        
        return newData
    }
    
}

let yearlyConfig = DWChartConfig(consuptionType: .electricity, data: yearlyData, period: .yearly, showLegend: true)
let monthlyConfig = DWChartConfig(consuptionType: .electricity, data: generateMonthlyData(forMonths: ["2-2023", "2-2024"]), period: .monthly, showLegend: true)
#Preview {
    VPMixedChartView(config: Bool.random() ? yearlyConfig:monthlyConfig)
}

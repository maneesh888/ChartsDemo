//
//  DummyData.swift
//  DewaCharts
//
//  Created by Maneesh on 04/03/2024.
//

import SwiftUI


let config = DWChartConfig(consuptionType: .water, data: generateRandomData, period: .yearly, showLegend: false)


var generateRandomData: [DWGraphData] {
    let calendar = Calendar.current
    let currentYear = calendar.component(.year, from: Date())
    
    var graphDataArray: [DWGraphData] = []
    
    for year in currentYear-2...currentYear {
        var color: Color
        
        // Assign different colors to each year
        switch year {
        case 2022:
            color = .red
        case 2023:
            color = .blue
        case 2024:
            color = .green
        default:
            color = .black
        }
        
        var points: [(time: Date, value: Double)] = []
                
                // Check if it's the current year to limit months
                let endMonth = year == currentYear ? calendar.component(.month, from: Date()) : 12
                
                for month in 1...endMonth {
                    // Generate random value for each month
                    let randomValue = Double.random(in: 500..<6000)
                    
                    // Create date components for the first day of each month
                    var dateComponents = DateComponents()
                    dateComponents.year = year
                    dateComponents.month = month
                    dateComponents.day = 1
                    
                    if let date = calendar.date(from: dateComponents) {
                        points.append((date, randomValue))
                    }
                }
        
        let graphData = DWGraphData(title: "\(year)", color: color, points: points)
        graphDataArray.append(graphData)
    }
    
    return graphDataArray
}

//
//  DummyData.swift
//  DewaCharts
//
//  Created by Maneesh on 04/03/2024.
//

import SwiftUI


let config = DWChartConfig(consuptionType: .water, data: generateMonthlyData(forMonths: 3), period: .monthly, showLegend: false)


var yearlyData: [DWGraphData] {
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


func generateMonthlyData(forMonths months: Int) -> [DWGraphData] {
    let calendar = Calendar.current
    let currentDate = Date()
    
    // Validate the months parameter
    guard (1...12).contains(months) else {
        print("Invalid number of months. Number of months must be between 1 and 12.")
        return []
    }
    
    var monthlyData: [DWGraphData] = []
    
    // Define an array of colors for different months
    let colors: [Color] = [.red, .blue, .green, .orange, .purple, .yellow, .pink, .cyan, .teal, .indigo, .gray, .black]
    
    // Generate data for each month
    for month in 1...months {
        // Generate a date with fixed month and year (January of current year)
        guard let startDateOfMonth = calendar.date(from: DateComponents(year: calendar.component(.year, from: currentDate), month: 1, day: 1)),
              let endDateOfMonth = calendar.date(byAdding: DateComponents(month: month, day: -1), to: startDateOfMonth) else {
            print("Error creating start date of month.")
            return []
        }
        
        var points: [(time: Date, value: Double)] = []
        
        // Generate random value for each day of the month
        for day in 1...31 {
            // Create a date with varying day component
            if let date = calendar.date(bySetting: .day, value: day, of: startDateOfMonth) {
                // Generate random value for each day
                let randomValue = Double.random(in: 20..<120)
                points.append((date, randomValue))
            }
        }
        
        // Assign color based on the index of the month
        let colorIndex = month - 1 // Adjust index to start from 0
        let color = colors[colorIndex % colors.count] // Wrap around to avoid index out of range
        
        // Create DWGraphData for the month with the assigned color
        let graphData = DWGraphData(title: "\(calendar.component(.year, from: currentDate))-\(month)", color: color, points: points)
        monthlyData.append(graphData)
    }
    
    return monthlyData
}


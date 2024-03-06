//
//  DummyData.swift
//  DewaCharts
//
//  Created by Maneesh on 04/03/2024.
//

import SwiftUI


let config = DWChartConfig(consuptionType: .electricity, data: generateMonthlyData(forMonths: [3,4]), period: .monthly, showLegend: true)


var yearlyData: [DWGraphData] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
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


func generateMonthlyData(forMonths months: [Int]) -> [DWGraphData] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!
    let currentDate = Date()

    // Validate the months parameter
    guard !months.isEmpty else {
        print("No months provided.")
        return []
    }

    // Find the month with the most number of days
    var maxDaysMonth = 1
    for month in months {
        var components = DateComponents()
        components.year = calendar.component(.year, from: currentDate)
        components.month = month
        
        if let date = calendar.date(from: components), let range = calendar.range(of: .day, in: .month, for: date) {
            if range.count > maxDaysMonth {
                maxDaysMonth = range.count
            }
        }
    }

    // Generate data for each month
    var monthlyData: [DWGraphData] = []
    for month in months {
        var points: [(time: Date, value: Double)] = []
        
        // Generate random value for each day of the month up to the maximum number of days
        for day in 1...maxDaysMonth {
            // Create a date with the month and varying day component
            if let date = calendar.date(from: DateComponents(year: calendar.component(.year, from: currentDate), month: month, day: day)) {
                // Check if the date is valid for the current month
                if calendar.component(.month, from: date) == month {
                    // Generate random value for each day
                    let randomValue = Double.random(in: 50..<150)
                    points.append((date, randomValue))
                }
            }
        }
        
        // Assign color based on the index of the month
        let colorIndex = month - 1 // Adjust index to start from 0
        let color = Color.blue // You can assign a color based on your logic
        
        // Create DWGraphData for the month with the assigned color
        let graphData = DWGraphData(title: "\(calendar.component(.year, from: currentDate))-\(month)", color: color, points: points)
        monthlyData.append(graphData)
    }
    
    return monthlyData
}


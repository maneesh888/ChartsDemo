//
//  DummyData.swift
//  DewaCharts
//
//  Created by Maneesh on 04/03/2024.
//

import SwiftUI


let config = DWChartConfig(consuptionType: .electricity, data: generateMonthlyData(forMonths: ["2-2023", "2-2024"]), period: .monthly, showLegend: true)


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


func generateMonthlyData(forMonths months: [String]) -> [DWGraphData] {
    var calendar = Calendar(identifier: .gregorian)
    calendar.timeZone = TimeZone(identifier: "UTC")!

    // Validate the months parameter
    guard !months.isEmpty else {
        print("No months provided.")
        return []
    }

    // Generate data for each month
    var monthlyData: [DWGraphData] = []
    for monthString in months {
        let components = monthString.components(separatedBy: "-")
        guard components.count == 2,
              let year = Int(components[1]),
              let month = Int(components[0]) else {
            print("Invalid month format: \(monthString)")
            continue
        }
        
        var points: [(time: Date, value: Double)] = []
        
        // Determine the maximum number of days for the month and year
        if let date = calendar.date(from: DateComponents(year: year, month: month)),
           let range = calendar.range(of: .day, in: .month, for: date) {
            
            // Generate random value for each day of the month up to the maximum number of days
            for day in 1...range.count {
                // Create a date with the month, year, and varying day component
                if let date = calendar.date(from: DateComponents(year: year, month: month, day: day)) {
                    // Generate random value for each day
                    let randomValue = Double.random(in: 50..<150)
                    points.append((date, randomValue))
                }
            }
        }
        
        
        let colors: [Color] = [.red, .green, .blue, .orange, .yellow, .purple]
        let color = colors.randomElement() ?? .black // You can assign a color based on your logic
        
        // Create DWGraphData for the month with the assigned color
        let graphData = DWGraphData(title: "\(year)-\(month)", color: color, points: points)
        monthlyData.append(graphData)
    }
    
    return monthlyData
}


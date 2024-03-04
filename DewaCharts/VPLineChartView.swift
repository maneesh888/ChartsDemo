//
//  VPLineChartView.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 25/02/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import SwiftUI
import Charts

enum LineChartType: String, CaseIterable, Plottable {
    case optimal = "2023"
    case outside = "2024"
    
    var color: Color {
        switch self {
        case .optimal: return .dewa
        case .outside: return .dm
        }
    }
    
}

struct VPLineChartData {
    
    var id = UUID()
    var date: Date
    var value: Double
    
    var type: LineChartType
}

struct VPLineChartView: View {
    let data: [ VPLineChartData]

    var body: some View {
        VStack(alignment: .leading) {
                   Text("Water Consumption")
                       .font(.system(size: 16, weight: .medium))
                       .padding()
                   Chart {
                       ForEach(data, id: \.id) { item in
                           LineMark(
                               x: .value("Weekday", item.date),
                               y: .value("Value", item.value)
                           )
                           
                           .foregroundStyle(item.type.color)
                           //                    .foregroundStyle(getLineGradient())
                           
                           .foregroundStyle(by: .value("Plot", item.type))
//                           .interpolationMethod(.catmullRom)
                           .interpolationMethod(.catmullRom)
                           .lineStyle(.init(lineWidth: 2))
                           .symbol {
                               Circle()
                                   .fill(item.type.color)
                                   .frame(width: 12, height: 12)
                                   .overlay {
                                       Text("\(Int(item.value))")
                                           .frame(width: 20)
                                           .font(.system(size: 8, weight: .medium))
                                           .offset(y: -15)
                                   }
                           }
                       }
                   }
                   .chartLegend(position: .top, alignment: .leading, spacing: 24){
                       HStack(spacing: 6) {
                           ForEach(LineChartType.allCases, id: \.self) { type in
                               Circle()
                                   .fill(type.color)
                                   .frame(width: 8, height: 8)
                               Text(type.rawValue)
                                   .foregroundStyle(type.color)
                                   .font(.system(size: 11, weight: .medium))
                           }
                       }
                   }
                   .chartXAxis {
                       AxisMarks(preset: .extended, values: .stride (by: .month)) { value in
                           AxisValueLabel(format: .dateTime.month())
                       }
                   }
                   .chartYAxis {
                       AxisMarks(preset: .extended, position: .leading, values: .stride(by: 5))
                   }.padding()
                .background(.regularMaterial, in: .rect(cornerRadius: 12))
       //            .preferredColorScheme(.dark)
               }
            .padding()
               .frame(height: 400)
    }
}

#Preview {
    VPLineChartView(data: chartData)
}


var chartData : [VPLineChartData] = {
    let sampleDate = Date().startOfDay.adding(.month, value: -10)!
    var temp = [VPLineChartData]()
    
    // Line 1
    for i in 0..<8 {
        let value = Double.random(in: 5...20)
        temp.append(
            VPLineChartData(
                date: sampleDate.adding(.month, value: i)!,
                value: value,
                type: .outside
            )
        )
    }
    
//    // Line 2
//    for i in 0..<8 {
//        let value = Double.random(in: 5...20)
//        temp.append(
//            VPLineChartData(
//                date: sampleDate.adding(.month, value: i)!,
//                value: value,
//                type: .optimal
//            )
//        )
//    }
    
    
//     Line 3
    for i in 0..<4 {
        let value = Double.random(in: 5...20)
        temp.append(
            VPLineChartData(
                date: sampleDate.adding(.month, value: i)!,
                value: value,
                type: .optimal
            )
        )
    }
    return temp
}()


extension Date {
    func adding (_ component: Calendar.Component, value: Int, using calendar: Calendar = .current) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }

    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}

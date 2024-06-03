//
//  VPLineChartView.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 25/02/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import SwiftUI
import Charts


struct VPLineChartView: View {
    
    let period: DWChartPeriod
    let data: [DWGraphData]
    let showLegend: Bool
    
    var timeStrideBy:Calendar.Component {
        switch period {
        case .monthly:
             return .day
        case .yearly:
            return .month
        }
    }
    
    
    var timeAxisValueFormat: Date.FormatStyle {
        switch period {
        case .monthly:
            return .dateTime.day()
        case .yearly:
            return .dateTime.month()
        }
    }
    
    
    private var strideValue: Double {
        if let highestRoundedPointCeilingValue = data.highestRoundedPointCeilingValue {
            return ceil(highestRoundedPointCeilingValue/5)
        }
        return 500
    }
    
    var body: some View {
        
        
        Chart {
            
            ForEach (data, id: \.title) { item in
                
                ForEach(item.points, id: \.time) {
                    
                        LineMark(
                            x: .value("Weekday", Date(timeIntervalSince1970: $0.time)),
                            y: .value("Value", $0.value)
                        )

                }
                .foregroundStyle(item.color.swiftUIColor)
                .foregroundStyle(by: .value("Plot", item.title))                 .interpolationMethod(.catmullRom)
                .interpolationMethod(.linear)
                .lineStyle(.init(lineWidth: 2))
                .symbol {
                    Circle()
                        .fill(item.color.swiftUIColor)
                        .frame(width: 12, height: 12)
                }
            }
        }
        .chartLegend( showLegend ? .visible : .hidden)
        .chartXAxis {
            AxisMarks(preset: .extended, values: .stride (by: timeStrideBy)) { value in
                AxisValueLabel(format:  timeAxisValueFormat)
            }
        }
        .chartYAxis {
            AxisMarks(preset: .extended, position: .leading, values: .stride(by: strideValue))
        }
        .chartLegend(position: .bottom) {
            
            HStack ( spacing: 10) {
                ForEach(data, id: \.id) { symbol in
                    HStack {
                        BasicChartSymbolShape.circle
                            .foregroundColor(symbol.color.swiftUIColor)
                            .frame(width: 8, height: 8)
                        Text(symbol.title)
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
            }
            .padding()
            
        }
    }
    
    
}

#Preview {
    VPLineChartView(period: .monthly, data: yearlyData.combineYear, showLegend: true)
}



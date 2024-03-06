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
    
    let period: DWChartConfig.Period
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
            
            ForEach (data, id: \.title) { year in
                ForEach(year.points, id: \.time) {
                    
                 //   if $0.value != 0 && Date() > $0.time {
                    
                        LineMark(
                            x: .value("Weekday", $0.time),
                            y: .value("Value", $0.value)
                        )
                 //   }
                    
                }
                .foregroundStyle(year.color)
                //                    .foregroundStyle(getLineGradient())
                
                .foregroundStyle(by: .value("Plot", year.title))
                //                           .interpolationMethod(.catmullRom)
                .interpolationMethod(.linear)
                .lineStyle(.init(lineWidth: 2))
                .symbol {
                    Circle()
                        .fill(year.color)
                        .frame(width: 12, height: 12)
                    //                                      .overlay {
                    //                                          Text(year.title)
                    //                                              .frame(width: 20)
                    //                                              .font(.system(size: 8, weight: .medium))
                    //                                              .offset(y: -15)
                    //                                      }
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
    }
    
    
}

#Preview {
    VPLineChartView(period: .monthly, data: yearlyData.combineYear, showLegend: true)
}


//
//  VPBarMarkView.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 28/02/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import SwiftUI
import Charts




struct VPBarMarkView:View {
    
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
        
                    ForEach(data, id: \.title) { item in
                        
                        ForEach(item.points, id: \.time) {
                            
                            BarMark(
                                x: .value("Time",  Date( timeIntervalSince1970: $0.time), unit: timeStrideBy),
                                y: .value("Consumption",  $0.value),
                                width: 10
                            )
                            
        
                        }
                        .foregroundStyle(item.color.swiftUIColor)
                        .foregroundStyle(by: .value("Time", item.title))
                        .position(by: .value("Time", item.title))
                    }
                }
                .chartXAxis {
                    AxisMarks(preset: .automatic, values: .stride (by: timeStrideBy)) { value in
                        AxisValueLabel(format: timeAxisValueFormat, multiLabelAlignment:.top)
                        
                    }
                }
                .chartYAxis {
                    AxisMarks(preset: .extended, position: .leading, values: .stride(by: strideValue))
                }
                .chartLegend( showLegend ? .visible : .hidden)
            
        
    }
}

#Preview {
    VPBarMarkView(period: .yearly, data: yearlyData.combineYear, showLegend: true)
}


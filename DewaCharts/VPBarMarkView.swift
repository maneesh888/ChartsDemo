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
    
    let timeStrideBy:Calendar.Component
    let data: [DWGraphData]
    let showLegend: Bool
    
    let timeAxisValueFormat: Date.FormatStyle
    
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
                                x: .value("Time",  $0.time, unit: .day),
                                y: .value("Consumption",  $0.value),
                                width: 10
                            )
        
                        }
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
    VPBarMarkView(timeStrideBy: .month, data: generateMonthlyData(forMonths: [1]), showLegend: true, timeAxisValueFormat: .dateTime.day())
}


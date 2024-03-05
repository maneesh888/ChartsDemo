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
    
    private var strideValue: Double {
        if let highestRoundedPointCeilingValue = data.highestRoundedPointCeilingValue {
            return ceil(highestRoundedPointCeilingValue/5)
        }
        return 500
    }
    
    var body: some View {
                Chart {
        
                    ForEach(data, id: \.title) { year in // 3 loops
                        
                        ForEach(year.points, id: \.time) {
                            
                            BarMark(
                                x: .value("Month",  $0.time, unit: .month),
                                y: .value("Consumption",  $0.value),
                                width: 10
                            )
        
                        }
                        .foregroundStyle(by: .value("Year", year.title))
                        .position(by: .value("Year", year.title))
                    }
                }
                .chartXAxis {
                    AxisMarks(preset: .automatic, values: .stride (by: timeStrideBy)) { value in
                        AxisValueLabel(format: .dateTime.month(), multiLabelAlignment:.top)
                        
                    }
                }
                .chartYAxis {
                    AxisMarks(preset: .extended, position: .leading, values: .stride(by: strideValue))
                }
                .chartLegend( showLegend ? .visible : .hidden)
            
        
    }
}

#Preview {
    VPBarMarkView(timeStrideBy: .month, data:generateRandomData.combineYear, showLegend: true)
}


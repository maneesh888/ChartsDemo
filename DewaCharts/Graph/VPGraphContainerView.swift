//
//  VPGraphContainerView.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 05/03/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import SwiftUI

struct VPGraphContainerView: View {
    
    var config: DWChartConfig
    
    @State var graphType: DWChartType = .bar
    @State var period: DWChartPeriod = .monthly
    
    var data: [DWGraphData] {
        switch period {
        case .yearly:
            config._yearlyData
        case .monthly:
            config._monthlyData
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(config.consuptionType.title)
                    .padding(4)
                Picker("", selection: $period) {
                  
                    ForEach(DWChartPeriod.allCases, id: \.self) {
                            Text($0.title)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 200)
            }
            VPMixedChartView(
                unitLabel: config.consuptionType.unitLabel,
                showLegend: true,
                data:data,
                graphType: $graphType,
                period: $period
            )
            .frame(height: 400)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial, in: .rect(cornerRadius: 12))
           
        } .padding()
    }
}

#Preview {
    VPGraphContainerView(config: sampleConfig)
}

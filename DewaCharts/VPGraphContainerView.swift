//
//  VPGraphContainerView.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 05/03/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import SwiftUI

struct VPGraphContainerView: View {
    
    var title: String
    var graphData: [DWGraphData]?
    @Binding var selection: DWChartConfig.Period
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .padding(4)
                Picker("", selection: $selection) {
                  
                    ForEach(DWChartConfig.Period.allCases, id: \.self) {
                            Text($0.title)
                    }
                }
                .pickerStyle(.segmented)
                .frame(width: 200)
            }
            VPMixedChartView(
                config: DWChartConfig(
                    consuptionType: .electricity,
                    graphType: .bar,
                    data: graphData ?? [],
                    period: selection,
                    showLegend: true
                )
            )
            .frame(height: 400)
            .frame(maxWidth: .infinity)
            .background(.regularMaterial, in: .rect(cornerRadius: 12))
           
        } .padding()
    }
}

//#Preview {
//    VPGraphContainerView(title: "Hello", graphData: [])
//}

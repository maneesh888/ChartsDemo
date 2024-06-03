//
//  ContentView.swift
//  DewaCharts
//
//  Created by Maneesh on 28/02/2024.
//

import SwiftUI

let sampleConfig = DWChartConfig(consuptionType: .electricity, showLegend: true)


let yearlyData = yearlyDummyData
let monthlyData = generateMonthlyData(forMonths: ["2-2023", "2-2024"])


struct ContentView: View {
    var body: some View {
       VPGraphContainerView(config: sampleConfig)
    }
}

#Preview {
    ContentView()
}

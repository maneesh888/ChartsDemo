//
//  VPBarMarkView.swift
//  DEWAVisionPro
//
//  Created by Satham Hussain on 28/02/2024.
//  Copyright © 2024 DEWA. All rights reserved.
//

import SwiftUI
import Charts


let cupertinoData: [(weekday: Date, sales: Int)] = [
    (Date(), 50), // Today's sales
    (Date().addingTimeInterval(-86400), 120), // Yesterday's sales
    (Date().addingTimeInterval(-172800), 90), // Two days ago sales
    // Add more data as needed...
]

let sfData: [(weekday: Date, sales: Int)] = [
    (Date(), 100), // Today's sales
    (Date().addingTimeInterval(-86400), 130), // Yesterday's sales
    (Date().addingTimeInterval(-172800), 110), // Two days ago sales
    // Add more data as needed...
]

let seriesData = [
    (city: "Cupertino", data: cupertinoData),
    (city: "San Francisco", data: sfData),
    (city: "New York", data: cupertinoData)
]


struct VPBarMarkView: View {
    var body: some View {
        Chart {
            ForEach(seriesData, id: \.city) { series in
                
                
                
                ForEach(series.data, id: \.weekday) {
                                
                    BarMark(
                        x: .value ("Weekday", $0.weekday, unit: .day),
                        y: .value("Sales", $0.sales),
                        width: 20
                    )
                }
                .foregroundStyle(by: .value("City", series .city))
//                .symbol(by: .value("City", series.city))
                .position (by: .value("City", series.city))

            }
        }.chartXAxis {
            AxisMarks(position: .bottom) { value in
                AxisValueLabel().foregroundStyle(.red)
            }
        }

//        .chartXAxis {
//            AxisMarks(preset: .extended, values: .stride (by: .month)) { value in
//                AxisValueLabel(format: .dateTime.month())
//            }
//        }
        .chartYAxis {
            AxisMarks(preset: .extended, position: .leading, values: .stride(by: 50))
        }.padding()
    }
}

#Preview {
    VPBarMarkView()
}

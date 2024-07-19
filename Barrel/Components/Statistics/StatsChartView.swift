//
//  StatsChartView.swift
//  Barrel
//
//  Created by KaayZenn on 01/05/2024.
//

import SwiftUI
import Charts

enum ChartType {
    case expenses, priceOfLitre, mileages
}

struct StatsChartView: View {
    
    // Builder
    var title: String
    var subTitle: String
    
    var chartType: ChartType
    var entries: [EntryEntity]
    
    var minValue: Double
    var maxValue: Double
    
    // MARK: -
    var body: some View {
        StatisticCellView(
            title: title,
            subTitle: subTitle) {
                Chart {
                    ForEach(entries) { entry in
                        LineMark(
                            x: .value("date", entry.date),
                            y: .value("yValue", yValue(entry: entry))
                        )
                    }
                    .interpolationMethod(.catmullRom)
                    .lineStyle(.init(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .foregroundStyle(Color.customYellow)
                }
            }
            .chartYScale(domain: minValue...maxValue)
            .chartXAxis(.hidden)
    } // End body
    
    // MARK: - FUNCTIONS
    func yValue(entry: EntryEntity) -> Double {
        switch chartType {
        case .expenses:
            return entry.price
        case .priceOfLitre:
            return entry.priceOfLitre
        case .mileages:
            return Double(entry.mileage)
        }
    }
    
} // End struct

// MARK: - Preview
#Preview {
    StatsChartView(
        title: "Preview",
        subTitle: "Preview subTitle",
        chartType: .expenses,
        entries: [],
        minValue: 0,
        maxValue: 10
    )
}

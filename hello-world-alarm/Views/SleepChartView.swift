//
//  SleepChartView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/20.
//

import SwiftUI

struct SleepChartView: View {
    let sleepCharts: SleepCharts
    var body: some View {
        TabView {
            ForEach(self.sleepCharts.charts) { chart in
                VStack {
                    Text(chart.date())
                    Text(chart.average())
                }
            }
        }.tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    SleepChartView(sleepCharts: SleepCharts(sleeps: Sleep.sampleData, durationKind: sleepChartDuration.day)).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

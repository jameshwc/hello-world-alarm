//
//  TimeInBedView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/16.
//

import SwiftUI

struct TimeInBedView: View {
    @Binding var sleeps: [Sleep]
    @State var sleepChartDurationUnit: sleepChartDuration = sleepChartDuration.day
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Sleep Chart", selection: $sleepChartDurationUnit){
                    ForEach(sleepChartDuration.allCases) { duration in
                        Text(duration.rawValue.capitalized).tag(duration.rawValue)
                    }
                }.tint(.orange).pickerStyle(.segmented).padding()
                SleepChartView(sleepCharts: SleepCharts(sleeps: sleeps, durationKind: sleepChartDurationUnit))
            }.navigationTitle("Time in Bed").navigationBarTitleTextColor(.white)
        }
    }
}

#Preview {
    TimeInBedView(sleeps: .constant(Sleep.sampleData)).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

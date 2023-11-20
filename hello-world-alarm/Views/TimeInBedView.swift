//
//  TimeInBedView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/16.
//

import SwiftUI

enum sleepChartDuration: String, Identifiable, CaseIterable {
    case day, week, month, six_months = "6 Months"
    var id: Self { self }
}

struct TimeInBedView: View {
    @State var sleepChart: sleepChartDuration = sleepChartDuration.day
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Sleep Chart", selection: $sleepChart){
                    ForEach(sleepChartDuration.allCases) { duration in
                        Text(duration.rawValue.capitalized).tag(duration.rawValue)
                    }
                }.tint(.orange).pickerStyle(.segmented).padding()
                SleepChartView(sleeps: [], duration: sleepChart)
            }.navigationTitle("Time in Bed").navigationBarTitleTextColor(.white)
        }
    }
}

#Preview {
    TimeInBedView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

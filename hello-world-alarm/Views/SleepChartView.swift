//
//  SleepChartView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/20.
//

import SwiftUI

struct SleepChartView: View {
    let sleeps: [Sleep]
    var duration: sleepChartDuration
    var body: some View {
        TabView {
            
        }
    }
}

#Preview {
    SleepChartView(sleeps: [Sleep(startTime: Date(), endTime: Date())],duration: sleepChartDuration.day).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

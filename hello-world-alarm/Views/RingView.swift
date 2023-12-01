//
//  RingView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/16.
//

import SwiftUI

struct RingView: View {
    @ObservedObject var alarm: Alarm
    let saveSleep: (Sleep) -> Void
    var body: some View {
        AlarmButtonView(label: "Stop Alarm") {
            alarm.stop()
            saveSleep(alarm.sleep!) // TODO better handle optional value
        }
    }
}

#Preview {
    RingView(alarm: Alarm(hour: 0, minute: 0, isRinging: false), saveSleep: {_ in }).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

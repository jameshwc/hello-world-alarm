//
//  RingView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/16.
//

import SwiftUI

struct RingView: View {
    @ObservedObject var alarm: Alarm
    var body: some View {
        AlarmButtonView(label: "Stop alarm") {
            alarm.stop()
        }
    }
}

#Preview {
    RingView(alarm: Alarm(hour: 0, minute: 0, isRinging: false))
}

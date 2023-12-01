//
//  RootView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/16.
//

import SwiftUI

struct RootView: View {
    @Binding var sleeps: [Sleep]
    let saveAction: (Sleep) -> Void
    @StateObject var alarm: Alarm = Alarm(
        hour: Calendar.current.component(.hour, from: Date()),
        minute: Calendar.current.component(.minute, from: Date()),
        isRinging: false)
    
    var body: some View {
        if let audioPlayer = alarm.audioPlayer, audioPlayer.isPlaying {
            RingView(alarm: alarm, saveSleep: saveAction)
        } else {
            TabView{
                AlarmView(alarm: alarm, saveSleep: saveAction).tabItem {
                    Label("Alarm", systemImage: "alarm.waves.left.and.right")
                }
                TimeInBedView(sleeps: $sleeps).tabItem {
                    Label("Time in bed", systemImage: "bed.double")
                }
            }.tint(Color.orange)
        }
    }
}

#Preview {
    RootView(sleeps: .constant(Sleep.sampleData), saveAction: {_ in}).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

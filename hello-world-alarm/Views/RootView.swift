//
//  RootView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/16.
//

import SwiftUI

struct RootView: View {
    @StateObject var alarm: Alarm = Alarm(
        hour: Calendar.current.component(.hour, from: Date()),
        minute: Calendar.current.component(.minute, from: Date()),
        isRinging: false)
    
    var body: some View {
        if let audioPlayer = alarm.audioPlayer, audioPlayer.isPlaying {
            RingView(alarm: alarm)
        } else {
            TabView{
                AlarmView(alarm: alarm).tabItem {
                    Label("Alarm", systemImage: "alarm.waves.left.and.right")
                }
                TimeInBedView().tabItem {
                    Label("Time in bed", systemImage: "bed.double")
                }
            }.tint(Color.orange)
        }
    }
}

#Preview {
    RootView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

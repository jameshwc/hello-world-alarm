//
//  ContentView.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/14.
//

import SwiftUI

extension View {
    /// Sets the text color for a navigation bar title.
    /// - Parameter color: Color the title should be
    ///
    /// Supports both regular and large titles.
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
    
        // Set appearance for both normal and large sizes.
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
    
        return self
    }
}

struct AlarmView: View {
    @ObservedObject var alarm: Alarm
    @State private var hideConfigure: Bool = true
    var saveSleep: (Sleep) -> Void
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Spacer()
                if alarm.isEnable && hideConfigure {
                    HStack{
                        Spacer()
                        Text(String(format: "%d : %02d", alarm.hour, alarm.minute)).font(.system(size: 64))
                        Spacer()
                    }
                    AlarmButtonView(label: "Set Time") {
                        alarm.reset()
                    }
                    if alarm.isEnable {
                        AlarmButtonView(label: "Clear Alarm") {
                            alarm.reset()
                        }.padding()
                        AlarmButtonView(label: "I've waken up") {
                            alarm.stop()
                            saveSleep(alarm.sleep!) // TODO: better handle optional
                        }
                    }
                }
                if !alarm.isEnable {
                    AlarmPickerView(hour: $alarm.hour, minute: $alarm.minute)
                    AlarmButtonView(label: "Confirm"){
                        alarm.enable(title: "Alarm")
                    }
                }
//                if hideConfigure && hidePicker {
//                    AlarmButtonView(label: "Configure") {
//                        self.hideConfigure = false
//                    }.padding()
//                }
//                if !hideConfigure {
//                    AlarmButtonView(label: "Confirm") {
//                        self.hideConfigure = true
//                    }
//                }
                Spacer()
            }
            .navigationTitle("Alarm").navigationBarTitleTextColor(.white)
            .padding()
        }
    }
}

#Preview {
    AlarmView(alarm: Alarm(hour: 0, minute: 0, isRinging: false), saveSleep: {_ in}).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
}

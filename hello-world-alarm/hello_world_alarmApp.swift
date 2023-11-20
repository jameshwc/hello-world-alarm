//
//  hello_world_alarmApp.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/14.
//

import SwiftUI
import AVFoundation

@main
struct hello_world_alarmApp: App {
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if let error = error {
                print(error)
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

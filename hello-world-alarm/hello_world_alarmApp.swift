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
    @StateObject private var store = SleepStore()
    @State private var errorWrapper: ErrorWrapper?
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if let error = error {
                print(error)
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            RootView(sleeps: $store.sleeps) { sleep in
                Task {
                    do {
                        try await store.add(sleep: sleep)
                    } catch {
                        self.errorWrapper = ErrorWrapper(error: error, guidance: "Failed to save sleep data.")
                    }
                }
            }.task {
                do {
                    try await store.load()
                } catch {
                    self.errorWrapper = ErrorWrapper(error: error, guidance: "Failed to load sleep data.")
                }
            }.sheet(item: self.$errorWrapper) {
                // TODO: look up why onDismiss is required
            } content: { wrap in
                ErrorView(errorWrapper: wrap)
            }
        }
    }
}

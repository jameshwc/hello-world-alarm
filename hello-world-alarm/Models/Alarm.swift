//
//  Alarm.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/18.
//

import SwiftUI
import AVFoundation

class Alarm: ObservableObject {
    @Published var hour: Int
    @Published var minute: Int
    @Published var audioPlayer: AVAudioPlayer?
    @Published var isRinging: Bool
    @Published var sleep: Sleep?
    @Published var isEnable: Bool
    
    init(hour: Int, minute: Int, isRinging: Bool) {
        self.hour = hour
        self.minute = minute
        self.isEnable = false
        self.isRinging = isRinging
    }
}

extension Alarm {
    
    func enable(id: String = UUID().uuidString, title: String) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error.localizedDescription)
        }
        guard let soundURL = Bundle.main.url(forResource: "iphone_early_riser", withExtension: "mp3") else {
            fatalError("Failed to find 'iphone_early_riser' ringtone")
        }
        self.audioPlayer = try! AVAudioPlayer(contentsOf: soundURL)
        self.isEnable = true
        self.sleep = Sleep(startTime: Date())
        let ringFile: String = "iphone_early_riser.mp3"
        self.generateNotification(id: id, title: title)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            guard self.isEnable else {
                timer.invalidate()
                return
            }
            let components = Calendar.current.dateComponents([.hour, .minute], from: Date())
            if components.minute == self.minute && components.hour == self.hour {
                self.playSound(ringFile: ringFile)
                timer.invalidate()
            }
        }
    }
    
    func generateNotification(id: String = UUID().uuidString, title: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "Alarm has been triggered!"
        content.categoryIdentifier = "alarm"
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        dateComponents.hour = self.hour
        dateComponents.minute = self.minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if error != nil {
                let _ = print(error ?? "error")
            }
        }
    }
    
    func playSound(ringFile: String) {
        self.isRinging = true
        self.audioPlayer!.play()
        print("sound is playing")
    }
    
    func reset() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        self.isEnable = false
    }
    
    func stop() {
        self.audioPlayer!.stop()
        self.reset()
        self.isRinging = false
        if let _ = self.sleep {
            self.sleep!.endTime = Date()
        } else {
            fatalError("Alarm.sleep is nil") // TODO error view
        }
    }
}

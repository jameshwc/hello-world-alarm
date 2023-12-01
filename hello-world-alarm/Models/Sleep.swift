//
//  Sleep.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/14.
//

import Foundation

struct Sleep: Codable, Identifiable {
    var id: UUID
    var startTime: Date
    var endTime: Date?
    init(startTime: Date, endTime: Date, id: UUID = UUID()) {
        self.startTime = startTime
        self.endTime = endTime
        self.id = id
    }
    init(startTime: Date, id: UUID = UUID()) {
        self.startTime = startTime
        self.id = id
    }
    
    var duration: TimeInterval? {
        return self.endTime?.timeIntervalSince(self.startTime)
    }
    
    var date: DateComponents {
        return self.endTime?.addingTimeInterval(-60*60*24).get(.year, .month, .day) 
            ?? self.startTime.get(.year, .month, .day)
    }
    
}

extension TimeInterval {
    // Helper function to format the time difference into a human-readable string
    func formattedString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.year, .month, .day, .hour, .minute, .second]

        return formatter.string(from: self)!
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Sleep {
    static var sampleData: [Sleep] = [
        Sleep(startTime: Date(), endTime: Date().addingTimeInterval(60*60*7.5)),
        Sleep(startTime: Date().addingTimeInterval(-60*60*24), endTime: Date().addingTimeInterval(-60*60*24 + 60*60*7)),
        Sleep(startTime: Date().addingTimeInterval(-60*60*24*2), endTime: Date().addingTimeInterval(-60*60*24*2 + 60*60*8)),
        Sleep(startTime: Date().addingTimeInterval(-60*60*24*3), endTime: Date().addingTimeInterval(-60*60*24*3 + 60*60*7.2)),
    ]
}

extension [Sleep] {
    // TODO function: filter by [day, week, month, 6 months]
    func filterByDuration(duration: sleepChartDuration) {
        
    }
    
    func average() -> String {
        guard self.count != 0 else {
            return TimeInterval(0).formattedString()
        }
        var durations: [TimeInterval] = []
        for sleep in self {
            if let duration = sleep.duration {
                durations.append(duration)
            }
        }
        
        return durations.average().formattedString()
    }
}

extension Sequence where Element: AdditiveArithmetic {
    /// Returns the total sum of all elements in the sequence
    func sum() -> Element { reduce(.zero, +) }
}

extension Collection where Element: BinaryFloatingPoint {
    /// Returns the average of all elements in the array
    func average() -> Element { isEmpty ? .zero : sum() / Element(count) }
}


extension Date {
    func date() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}

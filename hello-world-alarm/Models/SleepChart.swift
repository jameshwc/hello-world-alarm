//
//  SleepChart.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/25.
//

import Foundation

enum sleepChartDuration: String, Identifiable, CaseIterable {
    case day, week, month, six_months = "6 Months"
    var id: Self { self }
}

struct SleepChart: Codable, Identifiable {
    let sleeps: [Sleep]
    let id: UUID
    
    init(id: UUID = UUID(), sleeps: [Sleep]) {
        guard sleeps.count > 0 else {
            fatalError("Sleep Chart init: sleeps empty")
        }
        self.sleeps = sleeps
        self.id = id
    }
    
    func average() -> String {
        guard self.sleeps.count != 0 else {
            return "NAN"
        }
        var durations: [Double] = []
        for sleep in self.sleeps {
            if let duration = sleep.duration {
                durations.append(duration)
            }
        }
        return self.sleeps.average()
    }
    
    func date() -> String {
        if self.sleeps.count == 1 {
            return self.sleeps[0].date.readableDate()
        } else {
            return "\(self.sleeps[self.sleeps.count-1].date.readableDate()) - \(self.sleeps[0].date.readableDate())"
        }
    }
}

struct SleepCharts {
    var charts: [SleepChart] = []
    let durationKind: sleepChartDuration
    
    init(sleeps: [Sleep], durationKind: sleepChartDuration) {
        self.durationKind = durationKind
        let calendar = Calendar.current
        
        switch durationKind {
        case sleepChartDuration.day:
            for sleep in sleeps {
                charts.append(SleepChart(sleeps: [sleep]))
            }
        case sleepChartDuration.week:
            var weekCharts = [String: [Sleep]]()
            for sleep in sleeps {
                if let date = calendar.date(from: sleep.date) {
                    let year = calendar.component(.year, from: date)
                    let week = calendar.component(.weekOfYear, from: date)
                    let key = "\(year)-\(week)"
                    
                    if var weekArray = weekCharts[key] {
                        weekArray.append(sleep)
                        weekCharts[key] = weekArray
                    } else {
                        weekCharts[key] = [sleep]
                    }
                }
            }
            for weekChart in weekCharts {
                charts.append(SleepChart(sleeps: weekChart.value))
            }
        case sleepChartDuration.month:
            var monthCharts = [String: [Sleep]]()
            for sleep in sleeps {
                if let date = calendar.date(from: sleep.date) {
                    let year = calendar.component(.year, from: date)
                    let month = calendar.component(.month, from: date)
                    let key = "\(year)-\(month)"
                    
                    if var monthArray = monthCharts[key] {
                        monthArray.append(sleep)
                        monthCharts[key] = monthArray
                    } else {
                        monthCharts[key] = [sleep]
                    }
                }
            }
            for monthChart in monthCharts {
                charts.append(SleepChart(sleeps: monthChart.value))
            }
        case sleepChartDuration.six_months:
            var halfYearCharts = [String: [Sleep]]()
            for sleep in sleeps {
                if let date = calendar.date(from: sleep.date) {
                    let year = calendar.component(.year, from: date)
                    let month = calendar.component(.month, from: date)
                    let key: String = "\(year)-" + (month < 7 ? "f" : "l")
                    
                    if var halfYearArray = halfYearCharts[key] {
                        halfYearArray.append(sleep)
                        halfYearCharts[key] = halfYearArray
                    } else {
                        halfYearCharts[key] = [sleep]
                    }
                }
            }
            for halfYearChart in halfYearCharts {
                charts.append(SleepChart(sleeps: halfYearChart.value))
            }
        }
    }
}

extension DateComponents {
    func readableDate() -> String {
        return String(format: "%d-%d-%d", self.year ?? -1, self.month ?? -1, self.day ?? -1)
    }
}

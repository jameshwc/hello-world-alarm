//
//  Sleep.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/14.
//

import Foundation

struct Sleep: Codable {
    var startTime: Date
    var endTime: Date
    init(startTime: Date, endTime: Date) {
        self.startTime = startTime
        self.endTime = endTime
    }
}

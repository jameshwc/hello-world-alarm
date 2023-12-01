//
//  SleepStore.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/14.
//

import SwiftUI

@MainActor
class SleepStore: ObservableObject {
    @Published var sleeps: [Sleep] = []
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("sleeps.data")
    }
    
    func load() async throws {
        let task = Task<[Sleep], Error> {
            let file = try Self.fileURL()
            guard let data = try? Data(contentsOf: file) else {
                return []
            }
            let sleepRecords = try JSONDecoder().decode([Sleep].self, from: data)
            return sleepRecords
        }
        let sleeps = try await task.value
        self.sleeps = sleeps
    }
    
    func save() async throws {
        let task = Task {
            let file = try Self.fileURL()
            let data = try JSONEncoder().encode(self.sleeps)
            try data.write(to: file)
        }
        try await task.value
    }
    
    func add(sleep: Sleep) async throws {
        self.sleeps.append(sleep)
        try await self.save()
    }
}

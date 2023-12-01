//
//  ErrorWrapper.swift
//  hello-world-alarm
//
//  Created by James Hsu on 2023/11/22.
//

import Foundation

class ErrorWrapper: Identifiable {
    let error: Error
    let guidance: String
    
    init(error: Error, guidance: String) {
        self.error = error
        self.guidance = guidance
    }
}

//
//  Item.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    var duration: TimeInterval
    
    init(timestamp: Date = Date(), duration: TimeInterval = 0) {
        self.timestamp = timestamp
        self.duration = duration
    }
}

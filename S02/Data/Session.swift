//
//  Session.swift
//  S02
//
//  Created by Toby Glass on 27/04/2026.
//

import Foundation
import SwiftData

@Model
final class Session {
    var name: String
    var timestamp: Date
    var duration: TimeInterval
    var audioFilename: String

    init(name: String = "Session", timestamp: Date = Date(), duration: TimeInterval = 0, audioFilename: String = "") {
        self.name = name
        self.timestamp = timestamp
        self.duration = duration
        self.audioFilename = audioFilename
    }

    var audioURL: URL? {
        guard !audioFilename.isEmpty else { return nil }
        return FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(audioFilename)
    }
}

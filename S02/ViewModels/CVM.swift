//
//  CVM.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

import Foundation
import SwiftUI
import Observation

@Observable
class CVM: Observable {
    var language: LanguageType = .mandarin
    var recording: Bool = false
    var recordingItem: Item? = nil
    
    func mmss(from elapsed: TimeInterval) -> String {
        let totalSeconds = Int(elapsed.rounded(.down))
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

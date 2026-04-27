//
//  DayNote.swift
//  S02
//
//  Created by Toby Glass on 27/04/2026.
//

import Foundation
import SwiftData

@Model
class DayNote: Identifiable {
    var id: UUID
    var day: Date
    
    init(id: UUID = UUID(), day: Date = Date()) {
        self.id = id
        self.day = day
    }
}

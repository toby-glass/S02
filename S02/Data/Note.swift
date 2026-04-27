//
//  Note.swift
//  S02
//
//  Created by Toby Glass on 27/04/2026.
//

import Foundation
import SwiftData

@Model
class Note: Identifiable {
    var id: UUID
    var day: Date
    var text: String
    
    init(id: UUID = UUID(), day: Date = Date(), text: String = "") {
        self.id = id
        self.day = day
        self.text = text
    }
}

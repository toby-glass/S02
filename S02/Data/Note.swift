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
    var date: Date
    var text: String
    
    init(id: UUID = UUID(), date: Date = Date(), text: String = "") {
        self.id = id
        self.date = date
        self.text = text
    }
}

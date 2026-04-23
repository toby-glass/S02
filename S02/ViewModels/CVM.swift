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
}

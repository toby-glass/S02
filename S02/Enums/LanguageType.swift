//
//  LanguageType.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

import Foundation

enum LanguageType: String, CaseIterable {
    case mandarin, arabic
    
    var name: String {
        rawValue.capitalized
    }
}

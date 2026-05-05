//
//  HomeToolType.swift
//  S02
//
//  Created by Toby Glass on 05/05/2026.
//

import Foundation

enum HomeToolType: String, CaseIterable, Identifiable {
    case characters, scan, analyze
    
    var id: String {
        rawValue
    }
    
    var name: String {
        rawValue.capitalized
    }
    
    var icon: String {
        rawValue
    }
    
    var action: (_ vm: CVM) -> Void {
        return { vm in
            vm.toolView = self
        }
    }
}

//
//  SessionRow.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

import SwiftUI

struct SessionRow: View {
    
    var item: Item
    
    var body: some View {
        HStack {
            Text(item.timestamp.description)
            Spacer()
        }
    }
}

//#Preview {
//    SessionRow()
//}

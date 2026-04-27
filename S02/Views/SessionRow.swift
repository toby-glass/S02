//
//  SessionRow.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

import SwiftUI

struct SessionRow: View {
    
    @Environment(CVM.self) var vm
    var session: Session
    
    var body: some View {
        HStack(spacing: 12) {
            Text(session.timestamp.formatted(date: .abbreviated, time: .omitted))
            Spacer()
            Text(vm.mmss(from: session.duration))
            Image(systemName: "chevron.right")
                    .font(.system(size: 14))
        }
        .padding(12)
        .background(.background.opacity(0.001))
    }
}

//#Preview {
//    SessionRow()
//}

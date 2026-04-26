//
//  DayView.swift
//  S02
//
//  Created by Toby Glass on 26/04/2026.
//

import SwiftUI

struct DayView: View {
    
    @State private var text: String = ""
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .focused($focus)
                .onSubmit {
                    focus = false
                }
                .font(.system(size: 18))
        }
        .padding()
        .navigationTitle("Sun 26 Apr")
    }
}

#Preview {
    DayView()
}

//
//  DayCard.swift
//  S02
//
//  Created by Toby Glass on 26/04/2026.
//

import SwiftUI

struct DayCard: View {
    
    var date: Date
    var note: Note?
    
    var body: some View {
        NavigationLink {
            DayView(date: date, note: note)
        } label: {
            VStack(spacing: 10) {
                HStack {
                    VStack {
                        if let note {
                            Text(note.text)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .frame(width: 160, height: 198)
                .background(.gray.opacity(0.15))
                .clipShape(ConcentricRectangle(corners: .concentric(minimum: 14)))
                HStack {
                    Text(date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
                    Spacer()
                }
                .padding(.horizontal, 4)
            }
        }
    }
}

//#Preview {
//    DayCard()
//}

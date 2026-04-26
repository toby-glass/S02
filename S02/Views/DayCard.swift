//
//  DayCard.swift
//  S02
//
//  Created by Toby Glass on 26/04/2026.
//

import SwiftUI

struct DayCard: View {
    var body: some View {
        NavigationLink {
            DayView()
        } label: {
            VStack(spacing: 12) {
                HStack {
                    VStack {
                        Text("我喝红茶")
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .frame(width: 160, height: 198)
                .background(.gray.opacity(0.15))
                .clipShape(ConcentricRectangle(corners: .concentric(minimum: 14)))
                HStack {
                    Text("Sun 26 Apr")
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

//
//  DayCard.swift
//  S02
//
//  Created by Toby Glass on 26/04/2026.
//

import SwiftUI

struct DayCard: View {
    
    @Environment(CVM.self) var vm
//    var date: Date
    var note: Note
    
    var body: some View {
        NavigationLink {
            DayView(note: note)
        } label: {
            VStack(spacing: 12) {
                HStack {
                    VStack(spacing: 6) {
                        HStack {
                            if vm.language == .mandarin {
                                Text("\(Calendar.current.component(.month, from: note.date))月\(Calendar.current.component(.day, from: note.date))日")
                            } else if vm.language == .arabic {
                                Text("٢٨/٤")
                            }
                            Spacer()
                        }
                        .opacity(0.6)
//                        Divider()
                        HStack {
//                            if let note {
                                Text(note.text)
//                            }
                            Spacer()
                        }
                        .padding(.top, 2)
                        Spacer()
                    }
                    Spacer()
                }
                .font(.system(size: 24))
                .lineHeight(.loose)
//                .padding()
                .frame(height: 204)
                .background(.bg2.opacity(0.001))
//                .clipShape(ConcentricRectangle(corners: .concentric(minimum: 14)))
//                .overlay {
//                    ConcentricRectangle(corners: .concentric(minimum: 6))
//                        .stroke(.gray.opacity(0.25), lineWidth: 1)
//                }
//                HStack {
//                    Text(date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
//                    Spacer()
//                }
                .padding(.horizontal, 4)
            }
        }
    }
}

//#Preview {
//    DayCard()
//}

//
//  DayCard.swift
//  S02
//
//  Created by Toby Glass on 26/04/2026.
//

import SwiftUI

struct DayCard: View {
    
    @Environment(CVM.self) var vm
    var note: Note
    
    var body: some View {
        NavigationLink {
            DayView(note: note)
        } label: {
            VStack(spacing: 12) {
                HStack {
                    VStack(spacing: 6) {
                        HStack {
//                            if vm.language == .mandarin {
//                                Text("\(Calendar.current.component(.month, from: note.date))月\(Calendar.current.component(.day, from: note.date))日")
////                                Text(note.date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
//                            } else if vm.language == .arabic {
//                                Text("٢٨/٤")
//                            }
                            Spacer()
                        }
                        .opacity(0.6)
                        HStack {
                            Text(note.text)
                            Spacer()
                        }
                        .padding(.top, 2)
                        Spacer()
                    }
                    Spacer()
                }
                .font(.system(size: 24))
                .fontWeight(.semibold)
                .lineHeight(.loose)
                .padding()
                .frame(height: 204)
                .background(.card)
                .clipShape(RoundedRectangle(cornerRadius: 6, style: .continuous))
                HStack(spacing: 12) {
                    Text(note.name)
                    Text(note.date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
                        .opacity(0.6)
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

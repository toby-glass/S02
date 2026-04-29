//
//  DayView.swift
//  S02
//
//  Created by Toby Glass on 26/04/2026.
//

import SwiftUI
import SwiftData

struct DayView: View {
    
    @Environment(CVM.self) var vm
    @Environment(\.modelContext) var context
//    var date: Date
    var note: Note
    @State private var text: String = ""
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                if vm.language == .mandarin {
                    Text("\(Calendar.current.component(.month, from: note.date))月\(Calendar.current.component(.day, from: note.date))日")
                } else if vm.language == .arabic {
                    Text("٢٨/٤")
                }
                Spacer()
            }
            .opacity(0.6)
//            Divider()
            TextEditor(text: $text)
                .focused($focus)
                .textEditorStyle(.plain)
                .padding(0)
                
        }
        .padding(.top, 120)
        .font(.system(size: 24))
        .fontWeight(.medium)
        .lineHeight(.loose)
        .padding(12)
        .background(.bg1)
        .ignoresSafeArea()
        .onTapGesture {
            if focus {
                focus = false
            } else {
                focus = true
            }
        }
//        .navigationTitle(date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
        .onAppear {
//            if let note {
                text = note.text
//            }
        }
        .onDisappear {
//            if let note {
                if note.text != text {
                    amendNote(note: note)
                }
//            } else {
//                if !text.isEmpty {
//                    insertNote()
//                }
//            }
        }
    }
    
    func amendNote(note: Note) {
        note.text = text
    }
    
    func insertNote() {
        let note = Note(text: text)
        context.insert(note)
        
        print("dis")
        
        do {
            try context.save()
        } catch {
            print("could not save")
        }
    }
}

//#Preview {
//    DayView()
//}

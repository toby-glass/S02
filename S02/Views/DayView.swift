//
//  DayView.swift
//  S02
//
//  Created by Toby Glass on 26/04/2026.
//

import SwiftUI
import SwiftData

struct DayView: View {
    
    @Environment(\.modelContext) var context
    var date: Date
    var note: Note?
    @State private var text: String = ""
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .focused($focus)
                .font(.system(size: 24))
        }
        .padding()
        .onTapGesture {
            if focus {
                focus = false
            } else {
                focus = true
            }
        }
        .navigationTitle(date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
        .onAppear {
            if let note {
                text = note.text
            }
        }
        .onDisappear {
            if let note {
                if note.text != text {
                    amendNote(note: note)
                }
            } else {
                if !text.isEmpty {
                    insertNote()
                }
            }
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

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
    var note: Note
    @State private var name: String = ""
    @State private var text: String = ""
    @FocusState private var focus: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
//                if vm.language == .mandarin {
//                    Text("\(Calendar.current.component(.month, from: note.date))月\(Calendar.current.component(.day, from: note.date))日")
//                } else if vm.language == .arabic {
//                    Text("٢٨/٤")
//                }
//                Text(note.date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
                TextField("Title", text: $name)
                Spacer()
            }
            Divider()
            TextEditor(text: $text)
                .focused($focus)
                .padding(0)
                .font(.system(size: 24))
                
        }
        .padding(.top, 120)
        .font(.system(size: 28))
        .fontWeight(.semibold)
        .lineHeight(.loose)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(.card)
        .ignoresSafeArea()
        .onTapGesture {
            if focus {
                focus = false
            } else {
                focus = true
            }
        }
        .onAppear {
            name = note.name
            text = note.text
        }
        .onDisappear {
            if note.name != name {
                amendName(note: note)
            }
            if note.text != text {
                amendNote(note: note)
            }
        }
    }
    
    func amendName(note: Note) {
        note.name = name
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

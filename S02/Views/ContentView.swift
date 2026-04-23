//
//  ContentView.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(CVM.self) var vm
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(vm.language.name)
                        Spacer()
                    }
                    .font(.system(size: 32))
                    .offset(y: -65)
                }
                .padding()
            }
            .overlay(alignment: .bottom) {
                Button {
                    
                } label: {
                    HStack(spacing: 4) {
                        Text("Start")
                            .padding(8)
                        Image(systemName: "waveform")
                            .font(.system(size: 20))
                            .frame(width: 46, height: 46)
                            .background(.gray.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .foregroundStyle(.background)
                    .padding(5)
                    .background(.primary)
                    .clipShape(Capsule())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .buttonStyle(.plain)
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

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
    @State private var start: Date = Date()
    @State private var elapsed: TimeInterval = 0
    @State private var tickTimer: Timer? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(vm.language.name)
                        Spacer()
                    }
                    .font(.system(size: 32))
                    LazyVStack {
                        ForEach(items, id: \.id) { item in
                            NavigationLink(destination: SessionView(item: item)) {
                                SessionRow(item: item)
                            }
                        }
                    }
                    .padding(4)
                    .background(.gray.opacity(0.15))
                    .clipShape(ConcentricRectangle(corners: .concentric(minimum: 14)))
                }
                .offset(y: -65)
                .padding()
            }
            .overlay(alignment: .bottom) {
                Button {
                    record()
                } label: {
                    HStack(spacing: 2) {
                        Text(buttonText())
                            .padding(10)
                        Image(systemName: vm.recording ? "stop.fill" : "waveform")
                            .font(.system(size: 18))
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

    private func record() {
        if !vm.recording {
            vm.recording = true
            
            tickTimer?.invalidate()
            tickTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                elapsed = Date().timeIntervalSince(start)
            }
            RunLoop.main.add(tickTimer!, forMode: .common)
            
            let item = Item(timestamp: Date())
            vm.recordingItem = item
            start = Date()
        } else {
            guard let item = vm.recordingItem else { return }
            let duration = Date().timeIntervalSince(start)
            
            tickTimer?.invalidate()
            elapsed = 0
            
            item.duration = duration
            modelContext.insert(item)
            do {
                try modelContext.save()
            } catch {
                print("could not save")
            }
            
            vm.recordingItem = nil
            vm.recording = false
        }
    }
    
    private func buttonText() -> String {
        if vm.recording {
            return "\(vm.mmss(from: elapsed))"
        } else {
            return "Start"
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

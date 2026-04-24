//
//  ContentView.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

import SwiftUI
import SwiftData
import AVFoundation

struct ContentView: View {
    
    @Environment(CVM.self) var vm
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var start: Date = Date()
    @State private var elapsed: TimeInterval = 0
    @State private var tickTimer: Timer? = nil
    @State private var audioRecorder: AVAudioRecorder? = nil

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(spacing: 1) {
                        HStack {
                            Text("4月24日")
                            Spacer()
                        }
                        HStack {
                            Text("Mandarin")
                                .opacity(0.6)
                            Spacer()
                        }
                    }
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                    VStack {
                        HStack {
                            Text("Sessions")
                            Spacer()
                        }
                        .padding(.horizontal, 8)
                        LazyVStack {
                            ForEach(items, id: \.id) { item in
                                NavigationLink(destination: SessionView(item: item)) {
                                    SessionRow(item: item)
                                }
                            }
                        }
                        .padding(4)
                        .background(.gray.opacity(0.1))
                        .clipShape(ConcentricRectangle(corners: .concentric(minimum: 14)))
                    }
                    .padding(8)
                }
                .offset(y: -65)
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

            startAudioRecording()
        } else {
            guard let item = vm.recordingItem else { return }
            let duration = Date().timeIntervalSince(start)

            audioRecorder?.stop()
            audioRecorder = nil
            try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)

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

    private func startAudioRecording() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try session.setActive(true)
        } catch {
            print("audio session error: \(error)")
            return
        }

        session.requestRecordPermission { granted in
            guard granted else {
                print("microphone permission denied")
                return
            }
            DispatchQueue.main.async {
                let url = FileManager.default
                    .urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("\(UUID().uuidString).m4a")
                
                print(url.path)

                let settings: [String: Any] = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
                ]

                do {
                    let recorder = try AVAudioRecorder(url: url, settings: settings)
                    recorder.prepareToRecord()
                    recorder.record()
                    audioRecorder = recorder
                    vm.recordingItem?.audioFilename = url.lastPathComponent
                } catch {
                    print("recorder error: \(error)")
                }
            }
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

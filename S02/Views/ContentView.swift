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
    @Environment(\.modelContext) private var context
    @Query private var sessions: [Session]
    @Query private var notes: [Note]
    @State private var start: Date = Date()
    @State private var elapsed: TimeInterval = 0
    @State private var tickTimer: Timer? = nil
    @State private var audioRecorder: AVAudioRecorder? = nil
    @State private var editing: Bool = false
    let visibleDayCount: Int = 7

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(spacing: 1) {
                        HStack {
                            if vm.language == .mandarin {
                                Text("\(String(Calendar.current.component(.year, from: Date())))年\(Calendar.current.component(.month, from: Date()))月\(Calendar.current.component(.day, from: Date()))日")
                            } else if vm.language == .arabic {
                                Text("٢٨/٤")
                            }
                            Spacer()
                        }
                        HStack {
                            Text(vm.language.name)
                            Spacer()
                        }
                    }
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding()
                    HStack(spacing: 16) {
                        HStack(spacing: 4) {
                            Image("F1")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Characters")
                        }
                        HStack(spacing: 4) {
                            Image("F2")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Scan")
                        }
                        HStack(spacing: 4) {
                            Image("F3")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Analyse")
                        }
                        Spacer()
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal)
                    VStack(spacing: 24) {
                        // day
                        VStack(spacing: 16) {
                            LazyVStack(spacing: 12) {
                                ForEach(notes, id: \.id) { note in
                                    DayCard(note: note)
                                }
                            }
                        }
                        .padding(12)
                        Spacer()
                    }
                }
                .offset(y: -64)
            }
            .background(.bg2)
//            .scrollContentBackground(.hidden)
            .overlay(alignment: .bottom) {
                Button {
//                    record()
                    addNote()
                } label: {
                    HStack(spacing: 2) {
                        Text("Add note")
//                        Text(buttonText())
                            .padding(10)
//                        Image(systemName: vm.recording ? "stop.fill" : "waveform")
//                            .font(.system(size: 18))
//                            .frame(width: 46, height: 46)
//                            .background(.gray.opacity(0.3))
//                            .clipShape(Circle())
                    }
                    .foregroundStyle(.background)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background(.onset)
                    .clipShape(Capsule())
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
//                        Button("Add entry") {
//                            addNote()
//                        }
                        Menu("Language") {
                            ForEach(LanguageType.allCases, id: \.self) { language in
                                Button(language.name) {
                                    vm.language = language
                                }
                            }
                        }
//                        editing.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
        }
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .buttonStyle(.plain)
        .textFieldStyle(.plain)
        .textEditorStyle(.plain)
    }
    
    func addNote() {
        let note = Note(date: Date())
        context.insert(note)
        try? context.save()
    }
    
    private var recentDays: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<visibleDayCount).compactMap { offset in
            calendar.date(byAdding: .day, value: -offset, to: today)
        }
    }

    private func record() {
        if !vm.recording {
            vm.recording = true
            
            tickTimer?.invalidate()
            tickTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                elapsed = Date().timeIntervalSince(start)
            }
            RunLoop.main.add(tickTimer!, forMode: .common)
            
            let session = Session(timestamp: Date())
            vm.recordingSession = session
            start = Date()
            
            Task {
                await startAudioRecording()
            }
        } else {
            guard let item = vm.recordingSession else { return }
            let duration = Date().timeIntervalSince(start)

            audioRecorder?.stop()
            audioRecorder = nil
            
            vm.recordingSession = nil
            vm.recording = false
            
            try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
            
            tickTimer?.invalidate()
            elapsed = 0
            
            item.duration = duration
            context.insert(item)
            
            do {
                try context.save()
            } catch {
                print("could not save")
            }
            
            
        }
    }

    private func startAudioRecording() async {
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
                    vm.recordingSession?.audioFilename = url.lastPathComponent
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
                context.delete(sessions[index])
            }
        }
    }
}
//
//#Preview {
//    ContentView()
//}

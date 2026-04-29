//
//  SessionView.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

//import SwiftUI
//import AVFoundation
//
//struct SessionView: View {
//
//    @Environment(CVM.self) var vm
//    var session: Session
//    @State private var player: AVAudioPlayer? = nil
//    @State private var isPlaying: Bool = false
//
//    var body: some View {
//        VStack(spacing: 16) {
//            Text(session.timestamp.formatted(date: .abbreviated, time: .shortened))
//            Text(vm.mmss(from: session.duration))
//                .foregroundStyle(.secondary)
//
//            if session.audioURL != nil {
//                Button {
//                    togglePlayback()
//                } label: {
//                    Image(systemName: isPlaying ? "stop.fill" : "play.fill")
//                        .font(.system(size: 24))
//                        .frame(width: 60, height: 60)
//                        .background(.gray.opacity(0.2))
//                        .clipShape(Circle())
//                }
//                .buttonStyle(.plain)
//            } else {
//                Text("No audio file")
//                    .foregroundStyle(.secondary)
//            }
//        }
//        .padding()
//        .navigationTitle(session.timestamp.formatted(date: .abbreviated, time: .omitted))
//        .onDisappear {
//            player?.stop()
//            isPlaying = false
//        }
//    }
//
//    private func togglePlayback() {
//        if isPlaying {
//            player?.stop()
//            isPlaying = false
//            return
//        }
//
//        guard let url = session.audioURL else { return }
//
//        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
//            let p = try AVAudioPlayer(contentsOf: url)
//            p.prepareToPlay()
//            p.play()
//            player = p
//            isPlaying = true
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + p.duration) {
//                if player === p {
//                    isPlaying = false
//                }
//            }
//        } catch {
//            print("playback error: \(error)")
//        }
//    }
//}

//#Preview {
//    SessionView()
//}

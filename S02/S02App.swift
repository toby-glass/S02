//
//  S02App.swift
//  S02
//
//  Created by Toby Glass on 23/04/2026.
//

import SwiftUI
import SwiftData

@main
struct S02App: App {
    
    @State private var vm = CVM()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Session.self, DayNote.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(vm)
        }
        .modelContainer(sharedModelContainer)
    }
}

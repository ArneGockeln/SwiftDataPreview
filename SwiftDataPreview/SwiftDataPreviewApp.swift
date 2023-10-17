//
//  SwiftDataPreviewApp.swift
//  SwiftDataPreview
//
//  Created by Arne Gockeln on 17.10.23.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataPreviewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        #if DEBUG /// Running in Debug mode in Xcode sets always to store in memory
        .modelContainer(DataController.shared.sharedModelContainer(inMemory: true))
        #else
        .modelContainer(DataController.shared.sharedModelContainer())
        #endif
    }
}

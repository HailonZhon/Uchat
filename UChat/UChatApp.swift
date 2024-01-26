//
//  UChatApp.swift
//  UChat
//
//  Created by hailong on 2024/1/23.
//

import SwiftUI
import SwiftData

@main
struct UChatApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
//            ContentView()
//            LoginPage()
            MainPageButtonView()
        }
        .modelContainer(sharedModelContainer)
    }
}

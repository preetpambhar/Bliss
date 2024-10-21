//
//  BlissApp.swift
//  Bliss
//
//  Created by Preet Pambhar on 2024-09-23.
//

import SwiftUI

@main
struct BlissApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var locationViewModel = LocationSearchViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(locationViewModel)
        }
    }
}

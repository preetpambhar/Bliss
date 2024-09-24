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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

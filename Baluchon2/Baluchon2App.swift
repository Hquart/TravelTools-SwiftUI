//
//  Baluchon2App.swift
//  Baluchon2
//
//  Created by Naji Achkar on 20/06/2021.
//

import SwiftUI

@main
struct Baluchon2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

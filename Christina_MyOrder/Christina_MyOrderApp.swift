//
//  Christina_MyOrderApp.swift
//  Christina_MyOrder
//
//  Created by Christina Zammit on 2021-10-07.
//

import SwiftUI

@main
struct Christina_MyOrderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

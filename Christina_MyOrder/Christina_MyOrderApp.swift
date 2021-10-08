//
//  Christina_MyOrderApp.swift
//  Christina_MyOrder
//
//  Christina Zammit
//  991585165
//
//  Created by Christina Zammit on 2021-10-7.
//

import SwiftUI

@main
struct Christina_MyOrderApp: App {
    let persistenceController = PersistenceController.shared
    let coreDBHelper = CoreDBHelper(context: PersistenceController.shared.container.viewContext)
    
    var body: some Scene {
        WindowGroup {
            coffeeOrder()
                .environmentObject(coreDBHelper)
        }
    }
}

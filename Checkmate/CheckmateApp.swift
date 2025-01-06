//
//  CheckmateApp.swift
//  Checkmate
//
//  Created by Tanner George on 10/14/24.
//

import SwiftUI

@main
struct CheckmateApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

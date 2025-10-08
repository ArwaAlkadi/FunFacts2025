//
//  FunFactsApp.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 30/09/2025.
//

import SwiftUI

// MARK: - Entry Point
@main
struct FunFactsApp: App {
    @StateObject private var state = AppState()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
            }
            .environmentObject(state)
            .preferredColorScheme(.light)
        }
    }
}

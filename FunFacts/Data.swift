//
//  Data.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

/*
 💡 Reminder:
 Add this line in your Views if you need to access the shared/global data (name, avatar, coins, interests):
@EnvironmentObject var state: AppState
 */

import Foundation
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var name: String
    @Published var avatar: String
    @Published var interests: String
    @Published var coins: Int
    @Published var didOnboard: Bool

    init() {
        self.name       = UserDefaults.standard.string(forKey: "name") ?? "name"
        self.avatar     = UserDefaults.standard.string(forKey: "avatar") ?? "avatarEagle"
        self.interests  = UserDefaults.standard.string(forKey: "interests") ?? ""
        self.coins      = UserDefaults.standard.integer(forKey: "coins")
        self.didOnboard = UserDefaults.standard.bool(forKey: "didOnboard")
    }
}

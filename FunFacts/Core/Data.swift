//
//  Data.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

import Foundation
import Combine

// MARK: - App State
class AppState: ObservableObject {
    @Published var name: String
    @Published var avatar: String
    @Published var interests: String
    @Published var coins: Int
    @Published var didOnboard: Bool
    @Published var ownedAvatars: Set<String>

    // MARK: - Initialization
    init() {
        if UserDefaults.standard.object(forKey: "coins") == nil {
            UserDefaults.standard.set(10, forKey: "coins")
        }

        self.name = UserDefaults.standard.string(forKey: "name") ?? ""
        self.avatar = UserDefaults.standard.string(forKey: "avatar") ?? "avatarCamel"
        self.interests = UserDefaults.standard.string(forKey: "interests") ?? ""
        self.coins = UserDefaults.standard.integer(forKey: "coins")
        self.didOnboard = UserDefaults.standard.bool(forKey: "didOnboard")

        let defaultOwned: [String] = ["avatarCamel", "avatarCat"]
        let savedOwned = (UserDefaults.standard.array(forKey: "ownedAvatars") as? [String]) ?? defaultOwned
        self.ownedAvatars = Set(savedOwned)
    }

    // MARK: - Persistence
    func saveOwnedAvatars() {
        UserDefaults.standard.set(Array(ownedAvatars), forKey: "ownedAvatars")
    }
}

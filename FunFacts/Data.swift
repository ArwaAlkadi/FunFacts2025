//
//  Data.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

/*
 🚨 Team Note:
 Add this line in your Views if you need to access or add the data (name, avatar, coins, interests):
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

    // 👇 ملكيات الأفاتارات التي تم شراؤها/فتحها
    @Published var ownedAvatars: Set<String>

    init() {
        // أول تشغيل: ثبّتي رصيد افتراضي إذا ما كان محفوظ
        if UserDefaults.standard.object(forKey: "coins") == nil {
            UserDefaults.standard.set(10, forKey: "coins")
        }

        self.name       = UserDefaults.standard.string(forKey: "name") ?? ""
        self.avatar     = UserDefaults.standard.string(forKey: "avatar") ?? "avatarEagle"
        self.interests  = UserDefaults.standard.string(forKey: "interests") ?? ""
        self.coins      = UserDefaults.standard.integer(forKey: "coins")
        self.didOnboard = UserDefaults.standard.bool(forKey: "didOnboard")

        // الأفاتارات المملوكة (Free + اللي اشتراها)
        let defaultOwned = ["avatarCamel", "avatarCat"] // المجانية
        let savedOwned = (UserDefaults.standard.array(forKey: "ownedAvatars") as? [String]) ?? defaultOwned
        self.ownedAvatars = Set(savedOwned)
    }

    // حفظ الملكيات
    func saveOwnedAvatars() {
        UserDefaults.standard.set(Array(ownedAvatars), forKey: "ownedAvatars")
    }
}

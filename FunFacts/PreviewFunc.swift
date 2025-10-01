//
//  PreviewFunc.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

/*
🚨 Team Note:
 Call this function inside your Preview only.
it Used to initialize AppState class during your SwiftUI Preview.
 */

import SwiftUI

func makeStateForPreview (name: String = "",
                       avatar: String = "person.circle",
                       interests: String = "",
                       coins: Int = 0) -> AppState {
    let s = AppState()
    s.name = name
    s.avatar = avatar
    s.interests = interests
    s.coins = coins
    return s
}

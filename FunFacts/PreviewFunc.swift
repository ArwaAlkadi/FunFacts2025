//
//  PreviewFunc.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

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

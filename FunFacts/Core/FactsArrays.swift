//
//  FactsArrays.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

import SwiftUI

// MARK: - Fact Categories
var Random: [String] = [
    "The color orange is named after the fruit!"
]

var Human: [String] = [
    "Babies have 100 bones at birth, but they will lose around 20 by the time they are adults!"
]

var Nature: [String] = [
    "A shrimp's heart is in its head!"
]

var LifeStyle: [String] = [
    "The Eiffel Tower grows in the summer because of the heat!"
]

// MARK: - Fact Selector
func factOfToday(for category: String) -> String {
    let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0

    if category == "Random" {
        return Random.isEmpty ? "No facts available." : Random[day % Random.count]
    } else if category == "Human" {
        return Human.isEmpty ? "No facts available." : Human[day % Human.count]
    } else if category == "Nature" {
        return Nature.isEmpty ? "No facts available." : Nature[day % Nature.count]
    } else if category == "Lifestyle" {
        return LifeStyle.isEmpty ? "No facts available!!!." : LifeStyle[day % LifeStyle.count]
    } else {
        return "No facts available."
    }
}

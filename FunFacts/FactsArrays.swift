//
//  FactsArrays.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

import SwiftUI

var random:   [String] = ["R1","R2","R3"]
var human:    [String] = ["H1","H2"]
var nature:   [String] = ["N1","N2","N3","N4"]
var lifeStyle:[String] = ["L1","L2"]

func factOfToday(for category: String) -> String {
    let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
    
    if category == "Random" {
        return random.isEmpty ? "No facts available." : random[day % random.count]
    } else if category == "Human" {
        return human.isEmpty ? "No facts available." : human[day % human.count]
    } else if category == "Nature" {
        return nature.isEmpty ? "No facts available." : nature[day % nature.count]
    } else if category == "Lifestyle" {
        return lifeStyle.isEmpty ? "No facts available!!!." : lifeStyle[day % lifeStyle.count]
    } else {
        return "No facts available."
    }
}

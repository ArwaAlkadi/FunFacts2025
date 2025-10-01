//
//  FactsArrays.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

import SwiftUI


//هنا نضيف الفاكت
var random: [String] = []

var human: [String] = []

var Nature: [String] = []

var lifeStyle: [String] = []


// دالة ترجع الفاكت اليومية حسب الاهتمام
func factOfToday(for category: String) -> String {
    let day = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
    
    if category == "random" {
        return random.isEmpty ? "No facts available." : random[day % random.count]
    } else if category == "human" {
        return human.isEmpty ? "No facts available." : human[day % human.count]
    } else if category == "Nature" {
        return Nature.isEmpty ? "No facts available." : Nature[day % Nature.count]
    } else if category == "life style" {
        return lifeStyle.isEmpty ? "No facts available." : lifeStyle[day % lifeStyle.count]
    } else {
        return "No facts available."
    }
}

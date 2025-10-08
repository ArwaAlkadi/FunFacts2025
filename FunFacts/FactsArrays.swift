//
//  FactsArrays.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

import SwiftUI


//هنا نضيف الفاكت
var random: [String] = ["The color orange is named after thr fruit"]

var human: [String] = ["babys have 100 bones at birth, but they will lose around 20 by the time they are adults"]

var Nature: [String] = ["a shrimps heart is in it's head"]

var lifeStyle: [String] = ["the eiffel tower Grows in the summer time becuse of the heat"]


// دالة ترجع الفاكت اليومية حسب الاهتمام
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

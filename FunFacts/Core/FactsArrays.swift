//
//  FactsArrays.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 01/10/2025.
//

import SwiftUI

// MARK: - Fact Categories
var Random: [String] = [
    "The color orange is named after the fruit!",
    "The shortest war in history lasted only 38 minutes!",
    "Otters hold hands while sleeping so they don’t drift apart!",
    "A group of flamingos is called a flamboyance!",
    "Scotland’s national animal is the unicorn!",
    "Some cats are allergic to humans!",
    "Water can boil and freeze at the same time under certain conditions!",
    "Honey never spoils — archaeologists have found 3,000-year-old honey still edible!",
    "There’s a species of jellyfish that can live forever biologically!",
    "Bananas are berries, but strawberries aren’t!"
]

var Human: [String] = [
    "Babies have 100 bones at birth, but they will lose around 20 by the time they are adults!",
    "Your mouth produces about one liter of saliva each day!",
    "The human heart beats around 100,000 times per day!",
    "Humans shed about 600,000 particles of skin every hour!",
    "Your brain is about 60% fat!",
    "The strongest muscle in your body is the tongue (relative to its size)!",
    "Humans are the only species known to blush!",
    "Your nose can remember 50,000 different scents!",
    "Your stomach gets a new lining every 3 to 4 days!",
    "The acid in your stomach is strong enough to dissolve metals!"
]

var Nature: [String] = [
    "A shrimp's heart is in its head!",
    "Trees communicate with each other through underground fungi networks!",
    "A single honey bee visits up to 5,000 flowers in one day!",
    "Octopuses have three hearts!",
    "Some frogs can freeze solid and then thaw alive!",
    "Sharks existed before trees!",
    "Bees can see ultraviolet light, which humans can’t!",
    "A full-grown oak tree can produce over 10 million acorns in its lifetime!",
    "Cows have best friends and get stressed when separated!",
    "The Amazon rainforest produces about 20% of the world’s oxygen!"
]

var LifeStyle: [String] = [
    "The Eiffel Tower grows in the summer because of the heat!",
    "Laughing 100 times burns about 10 minutes’ worth of calories!",
    "People spend about 6 months of their lifetime waiting for red lights to turn green!",
    "Yawning helps cool your brain!",
    "Music can help reduce anxiety and lower blood pressure!",
    "Drinking water after eating reduces acidity and eases digestion!",
    "Smiling elevates mood by releasing dopamine and serotonin!",
    "Reading in dim light doesn’t damage your eyes — just tires them!",
    "Walking for 15 minutes after dinner helps blood sugar regulation!",
    "Sleeping on your left side can improve digestion!"
]

// MARK: - Fact by specific date
func factOfToday(category: String, on date: Date) -> String {
    let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: date) ?? 0

    switch category {
    case "Random":
        return Random.isEmpty ? "No facts available." : Random[dayOfYear % Random.count]
    case "Human":
        return Human.isEmpty ? "No facts available." : Human[dayOfYear % Human.count]
    case "Nature":
        return Nature.isEmpty ? "No facts available." : Nature[dayOfYear % Nature.count]
    case "Lifestyle":
        return LifeStyle.isEmpty ? "No facts available." : LifeStyle[dayOfYear % LifeStyle.count]
    default:
        return "No facts available."
    }
}

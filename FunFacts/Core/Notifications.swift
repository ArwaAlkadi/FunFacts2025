//
//  Notifications.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 05/10/2025.
//

import SwiftUI
import UserNotifications

// MARK: - Daily Notification Scheduler
func scheduleDailyFunFact(using state: AppState) {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
        if granted {
            center.removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
            
            let content = UNMutableNotificationContent()
            content.title = "Hello \(state.name) 👋"
            content.body = factOfToday(for: state.interests)
            content.sound = .default

            var time = DateComponents()
            time.hour = 20
            time.minute = 50

            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)

            let request = UNNotificationRequest(
                identifier: "dailyReminder",
                content: content,
                trigger: trigger
            )

            center.add(request)
        }
    }
}

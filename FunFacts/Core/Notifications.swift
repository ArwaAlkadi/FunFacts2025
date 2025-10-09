//
//  Notifications.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 05/10/2025.
//

import UserNotifications

// MARK: - Daily Notification Scheduler
func scheduleDailyFunFact(using state: AppState) {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
        if granted {
            center.removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
            
            let name = UserDefaults.standard.string(forKey: "name") ?? "there"
            let interests = UserDefaults.standard.string(forKey: "interests") ?? "Random"
            let fact = factOfToday(for: interests)
            
            let content = UNMutableNotificationContent()
            content.title = "Hello \(name) 👋"
            content.body = fact
            content.sound = .default

            var time = DateComponents()
            time.hour = 11
            time.minute = 15

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

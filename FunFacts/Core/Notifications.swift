//
//  Notifications.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 05/10/2025.
//
import UserNotifications

// MARK: - Daily Notification Scheduler
func scheduleDailyFunFact(name: String, interests: String, atHour hour: Int, minute: Int) {
    let center = UNUserNotificationCenter.current()

    center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
        guard granted else { return }

        center.removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])

        let content = UNMutableNotificationContent()
        content.title = "Hello \(name.isEmpty ? "there" : name) 👋"
        content.body  = factOfToday(for: interests.isEmpty ? "Random" : interests)
        content.sound = .default

        var time = DateComponents()
        time.hour = hour
        time.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)
        let request = UNNotificationRequest(identifier: "dailyReminder",
                                            content: content,
                                            trigger: trigger)

        center.add(request)
    }
}

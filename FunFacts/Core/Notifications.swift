//
//  Notifications.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 05/10/2025.
//
import UserNotifications

// MARK: - Batch schedule up to 64 notifications ahead
func scheduleFunFactsBatch(
    name: String,
    interests: String,
    hour: Int,
    minute: Int,
    daysAhead: Int = 64
) {
    let center = UNUserNotificationCenter.current()

    center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
        guard granted else { return }

        center.removePendingNotificationRequests(withIdentifiers: ["dailyReminder"]) 
        center.removeAllPendingNotificationRequests()

        let clampedDays = max(1, min(daysAhead, 64))
        let calendar = Calendar.current
        let safeName = name.isEmpty ? "there" : name
        let safeInterest = interests.isEmpty ? "Random" : interests

        for offset in 0..<clampedDays {

            let baseDate = calendar.date(byAdding: .day, value: offset, to: Date()) ?? Date()

            var comps = calendar.dateComponents([.year, .month, .day], from: baseDate)
            comps.hour = hour
            comps.minute = minute

            let fact = factOfToday(category: safeInterest, on: baseDate)

            let content = UNMutableNotificationContent()
            content.title = "Hello \(safeName) 👋"
            content.body  = fact
            content.sound = .default

            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)

            let id = String(format: "dailyReminder-%04d-%02d-%02d", comps.year ?? 0, comps.month ?? 0, comps.day ?? 0)

            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            center.add(request)
        }
        
    }
}

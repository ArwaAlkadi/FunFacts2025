//
//  Notifications.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 05/10/2025.
//

import SwiftUI
import UserNotifications

func scheduleDailyFunFact(using state: AppState) {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
        if granted {
            // نحذف الجدول القديم (عشان ما تتكرر نفس الإشعارات)
            center.removePendingNotificationRequests(withIdentifiers: ["dailyReminder"])
            
            let content = UNMutableNotificationContent()
            content.title = "Hello \(state.name) 👋"
            content.body = factOfToday(for: state.interests)
            content.sound = .default

            // نحدد وقت الإشعار (مثلاً الساعة 8 الصبح)
            var time = DateComponents()
            time.hour = 20
            time.minute = 50

            // يتكرر كل يوم في نفس الوقت
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

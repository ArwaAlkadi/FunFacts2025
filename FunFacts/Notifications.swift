//
//  Notifications.swift
//  FunFacts
//
//  Created by Arwa Alkadi on 05/10/2025.
//

import SwiftUI
import UserNotifications

func funFactNotification() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound]) { granted, _ in
        if granted {
            center.removeAllPendingNotificationRequests()

            let content = UNMutableNotificationContent()
            content.title = "Hello Mashael 👋"
            content.body = "Did you Know That Bananas are berries… but strawberries are not!"
            content.sound = .default

            var time = DateComponents()
            time.hour = Calendar.current.component(.hour, from: Date())
            time.minute = Calendar.current.component(.minute, from: Date()) + 3
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: time, repeats: true)

            let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
            center.add(request)
        }
    }
}

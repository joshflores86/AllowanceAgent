//
//  NotificationManager.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager()
    
    func requestAuthorization() {
        let option: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: option) { success, error in
            if let error = error {
                print("Error \(error)")
            }else{
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification(dueDate: String, dueTime: String) {
        let content = UNMutableNotificationContent()
        content.title = "Pay day"
        content.subtitle = "Payment is due \(dueDate)"
        content.sound = .default
        content.badge = 1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        let dateString = dateFormatter.date(from: "\(dueDate) \(dueTime)")
        
        guard let newDate = dateString else{return}
        
        if newDate < Date() {
            var dateComponents = Calendar.current.dateComponents([.month, .day, .year, .hour, .minute], from: newDate)
            //            var dateComponents = DateComponents()
            dateComponents.hour = 16
            dateComponents.minute = 00
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            print(trigger.dateComponents.hour!)
            print(trigger.dateComponents.minute!)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in
                
                if let error = error {
                    print("Error Scheduling Notification \(error)")
                }else{
                    print("Successful Notification")
                }
            }
        }else{
            print("Error: Invalid date or time format")
        }
    }
}


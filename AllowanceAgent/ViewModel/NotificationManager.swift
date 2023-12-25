//
//  NotificationManager.swift
//  AllowanceAgent
//
//  Created by Josh Flores on 10/16/23.
//

import Foundation
import UserNotifications
import UIKit

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
    func removeBubble() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
    
    func scheduleNotification(dueDate: String, dueTime: String, name: String) {
        let content = UNMutableNotificationContent()
        content.title = "\(name) PAY DAY"
        content.subtitle = "Payment is due \(dueDate)"
        content.sound = .default
        content.badge = 1
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy HH:mm"
        guard let dateString = dateFormatter.date(from: "\(dueDate) \(dueTime)") else {
            print("Error: Invalid date format")
            return
        }
        
        
        
        if dateString > Date() {
            var dateComponents = Calendar.current.dateComponents([.month, .day, .year, .hour, .minute], from: dateString)
            //            var dateComponents = DateComponents()
                        
            let timeZone = TimeZone(identifier: "America/New_York")
            dateComponents.timeZone = timeZone
            
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


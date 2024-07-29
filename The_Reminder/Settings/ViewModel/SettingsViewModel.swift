//
//  SettingsViewModel.swift
//  The_Reminder
//
//  Created by Bharath on 30/05/24.
//

import Foundation
import UserNotifications

class SettingsViewModel:NSObject{
    
    func createIntervals(start: String, end: String) -> [String]? {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        guard let startDate = formatter.date(from: start),
              let endDate = formatter.date(from: end) else {
            return nil
        }
        
        let calendar = Calendar.current
        var intervals: [String] = []
        var currentTime = startDate
        
        
        while currentTime <= endDate {
            intervals.append(formatter.string(from: currentTime))
            currentTime = calendar.date(byAdding: .minute, value: 90, to: currentTime)!
        }
        
        return intervals
    }
    
    func calculateTotalIntake() -> Int{
        var result = 0
        let gender = UserDefaults.standard.string(forKey: "selectedGender")
        let weight = UserDefaults.standard.integer(forKey: "selectedWeight")
        if gender == "Male"{
            result = weight * 35
        }else{
            result = weight * 31
        }
        UserDefaults.standard.set(result, forKey: "totalQuans")
        return result
    }
    
    func scheduleNotificationInterval(intervals : [String]){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        for interval in intervals {
            
            let formatter = DateFormatter()
            formatter.dateFormat = "h:mm a"
            
            guard let startDate = formatter.date(from: interval) else{
                print("Invalid time format. Please use the format: 'hh:mm a'")
                return
            }
            let calendar = Calendar.current
            let currentTime = startDate
            
            let triggerTime = calendar.dateComponents([.hour, .minute], from: currentTime)
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)
            
            
            let content = UNMutableNotificationContent()
            content.title = "It's time to drink water"
            content.body = "After drinking,touch the cup to confirm"
            content.sound = .default
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request)
            
        }
    }

}


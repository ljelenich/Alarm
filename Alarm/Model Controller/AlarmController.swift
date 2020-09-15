//
//  AlarmController.swift
//  Alarm
//
//  Created by LAURA JELENICH on 9/14/20.
//  Copyright © 2020 LAURA JELENICH. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: AnyObject {
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

class AlarmController: AlarmScheduler {

    //MARK: - Source of truth
    static let shared = AlarmController()
    
    //MARK: - Properties
    var alarms: [Alarm] = []
    
    //MARK: - Init
    init() {
        loadFromPersistentStorage()
    }
    
    //MARK: - Helper Functions
    func addAlarm(fireDate: Date, name: String, enabled: Bool) -> Alarm {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(newAlarm)
        if newAlarm.enabled {
            scheduleUserNotifications(for: newAlarm)
        } else {
            cancelUserNotifications(for: newAlarm)
        }
        saveToPersistentStorage()
        return newAlarm
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
        cancelUserNotifications(for: alarm)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled.toggle()
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        saveToPersistentStorage()
    }
    
    //MARK: - Persistence
    private static func fileUrl() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Alarm.json")
        return fileURL
    }
    
    func saveToPersistentStorage() {
        do {
            let data = try JSONEncoder().encode(alarms)
            try data.write(to: AlarmController.fileUrl())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    func loadFromPersistentStorage() {
        do {
            let data = try Data(contentsOf: AlarmController.fileUrl())
            alarms = try JSONDecoder().decode([Alarm].self, from: data)
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Time is up"
        content.sound = UNNotificationSound.default
        
        let date = alarm.fireDate
        let calendar = Calendar.current
        // Date Components should be within the scope of alarm....
        let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error)
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}


//
//  AlarmController.swift
//  Alarm
//
//  Created by LAURA JELENICH on 9/14/20.
//  Copyright © 2020 LAURA JELENICH. All rights reserved.
//

import Foundation

class AlarmController {
    
    static let shared = AlarmController()
    
    var alarms: [Alarm] = []
    
    let mockAlarms: [Alarm] = {
        let alarm1 = Alarm(fireDate: Date(), name: "newAlarm", enabled: true, uuid: "")
        let alarm2 = Alarm(fireDate: Date(), name: "second", enabled: true, uuid: "")
        return [alarm1, alarm2]
    }()
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name, enabled: true, uuid: "")
        alarms.append(newAlarm)
        print("alarm added")
    }
    
    func updateAlarm(alarm: Alarm, fireDate: Date, name: String, isOn: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = isOn
        print("alarm updated")
        
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
        print("alarm deleted")
    }
    
    static func toggleIsOn(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
}

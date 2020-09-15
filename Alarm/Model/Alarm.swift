//
//  Alarm.swift
//  Alarm
//
//  Created by LAURA JELENICH on 9/14/20.
//  Copyright © 2020 LAURA JELENICH. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = UUID().uuidString
    }
    
    var fireTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let date = dateFormatter.string(from: fireDate)
        return date
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.name == rhs.name && lhs.fireDate == rhs.fireDate && lhs.fireDate == rhs.fireDate
    }
    
    
}

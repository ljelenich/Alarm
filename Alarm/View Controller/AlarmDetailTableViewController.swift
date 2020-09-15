//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by LAURA JELENICH on 9/14/20.
//  Copyright © 2020 LAURA JELENICH. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var alarmDisableEnableButton: UIButton!
    
    // MARK: - Properties
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    var alarmIsOn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Buttons
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn.toggle()
        alarmDisableEnableButton.setTitle(alarmIsOn ? "Enable" : "Disable", for: .normal)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let alarmName = alarmNameTextField.text, !alarmName.isEmpty  else {return}
        
        if let alarm = alarm {
            AlarmController.shared.updateAlarm(alarm: alarm, fireDate: alarmDatePicker.date, name: alarmName, isOn: alarmIsOn)
        } else {
            AlarmController.shared.addAlarm(fireDate: alarmDatePicker.date, name: alarmName, enabled: alarmIsOn)
        }
        
    }

    //MARK: Helper Functions
    func updateViews() {
        guard let alarm = alarm else {return}
        alarmNameTextField.text = alarm.name
        alarmDatePicker.date = alarm.fireDate
        alarmIsOn = alarm.enabled
    }
}

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
    var alarm: Alarm?
    var alarmIsOn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Buttons
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn.toggle()
        alarmDisableEnableButton.setTitle(alarmIsOn ? "On" : "Off", for: .normal)
        alarmDisableEnableButton.backgroundColor = alarmIsOn ? .black : .gray
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let alarmName = alarmNameTextField.text else {return}
        let datePickerDate = alarmDatePicker.date
        if let alarm = alarm {
            AlarmController.shared.updateAlarm(alarm: alarm, fireDate: datePickerDate, name: alarmName, enabled: alarmIsOn)
        } else {
            AlarmController.shared.addAlarm(fireDate: datePickerDate, name: alarmName, enabled: alarmIsOn)
        }
        navigationController?.popToRootViewController(animated: true)
    }

    //MARK: Helper Functions
    private func updateViews() {
        if let alarm = alarm {
            alarmNameTextField.text = alarm.name
            alarmDatePicker.date = alarm.fireDate
            alarmIsOn = alarm.enabled
            
        }
        alarmDisableEnableButton.setTitle(alarmIsOn ? "On" : "Off", for: .normal)
        alarmDisableEnableButton.backgroundColor = alarmIsOn ? .black : .gray
    }
}

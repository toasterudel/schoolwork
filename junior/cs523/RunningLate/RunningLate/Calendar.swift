//
//  Calendar.swift
//  RunningLate
//
//  Created by Chris Rudel on 4/30/19.
//  Copyright © 2019 Chris Rudel. All rights reserved.
//
//  CS 523
//  Professor Damopolous
//  Running Late - Main.swift
//  I pledge my honor that I have abided by the Stevens Honor System - Christopher Rudel

import UIKit

class Calendar: UIViewController, UINavigationControllerDelegate {
    
    var days: [Weekday] = []
    var timeOfAlarm:String = ""
    
    @IBAction func switchToggle(_ sender: Any) {
        let tag = (sender as AnyObject).tag!
        print(tag)
        days[tag].enabled = !days[tag].enabled
        //print(days)
    }
    
    @IBOutlet weak var sunSwitch: UISwitch!
    @IBOutlet weak var monSwitch: UISwitch!
    @IBOutlet weak var tuesSwitch: UISwitch!
    @IBOutlet weak var wedSwitch: UISwitch!
    @IBOutlet weak var thursSwitch: UISwitch!
    @IBOutlet weak var friSwitch: UISwitch!
    @IBOutlet weak var satSwitch: UISwitch!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func datePickerAction(_ sender: Any) {
        //print("datepicker")
        /* Below the var should have a string that looks like:
           "Sunday, May 5, 2019 at 9:00:00 AM Eastern Daylight Time"
           in an array with each word its own element separated by space */
        
        let dateDescription = datePicker.date.description(with: .current).components(separatedBy: " ")
        //print(timeOfAlarm)
        /* The string below should look like "9:00 AM" */
        var time = dateDescription[5]
        time.removeLast(3)
        time += " "
        time += dateDescription[6]
        timeOfAlarm = time
        //print(timeOfAlarm)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.delegate = self
        fixSwitches()
        //datePicker.timeZone = TimeZone(secondsFromGMT: -4*60*60)
        var alarmTimeCopy: String
        if(timeOfAlarm.count == 7){
            alarmTimeCopy = "0" + timeOfAlarm
        }else{
            alarmTimeCopy = timeOfAlarm
        }
        /* we need to format the time correctly so that we can apply the users
           time to the datePicker correctly
           we made the extra variable alarmTimeCopy so that we wouldn't mess up
           the rest of the code in the other view controllers */
        print(alarmTimeCopy)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.date(from: alarmTimeCopy)
        datePicker.date = date!
        super.viewDidAppear(true)
    }
    
    func fixSwitches(){
        sunSwitch.isOn = days[0].enabled
        monSwitch.isOn = days[1].enabled
        tuesSwitch.isOn = days[2].enabled
        wedSwitch.isOn = days[3].enabled
        thursSwitch.isOn = days[4].enabled
        friSwitch.isOn = days[5].enabled
        satSwitch.isOn = days[6].enabled
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? Main)?.AlarmDays = days
        (viewController as? Main)?.AlarmTime = timeOfAlarm
    }

}

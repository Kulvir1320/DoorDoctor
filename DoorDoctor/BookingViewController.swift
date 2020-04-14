//
//  BookingViewController.swift
//  DoorDoctor
//
//  Created by Alisha Thind on 2020-04-14.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

class BookingViewController: UIViewController {

    @IBOutlet var dateLabel: UITextField!
    @IBOutlet var timeLabel: UITextField!
    @IBOutlet var datePickerLabel: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        datePickerLabel?.datePickerMode = .dateAndTime
               datePickerLabel?.minimumDate = Date.calculateData(day: 1, month: 1, year: 2020, hour: 0, minute: 0)
               datePickerLabel?.maximumDate = Date.calculateData(day: 31, month: 1, year: 2021, hour: 0, minute: 0)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func valueChanged(_ sender: UIDatePicker) {
        
        dateLabel?.text = " \(sender.date.getDayMonthYearHourMinuteSecond().day)-\(sender.date.getDayMonthYearHourMinuteSecond().month)-\(sender.date.getDayMonthYearHourMinuteSecond().year)"
        timeLabel.text = " \(sender.date.getDayMonthYearHourMinuteSecond().hour):\(sender.date.getDayMonthYearHourMinuteSecond().minute)"
    }
}

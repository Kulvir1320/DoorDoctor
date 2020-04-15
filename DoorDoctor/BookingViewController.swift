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
    
    
    @IBOutlet var dNameLabel: UILabel!
    @IBOutlet var dPhoneLabel: UILabel!
    @IBOutlet var dEmailLabel: UILabel!
    
    @IBOutlet var uNameTxtField: UITextField!
    @IBOutlet var uEmailTxtField: UITextField!
    @IBOutlet var uPhoneTxtField: UITextField!
    @IBOutlet var uGenderTxtField: UITextField!
    
    @IBOutlet var bookButton: UIButton!
    
    var del_DListVC : doctorListViewController?
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
         setUpElements()
        // Do any additional setup after loading the view.
        print(Doctor.doctor[selectedIndex].name)
        print(Doctor.doctor[selectedIndex].phone)
        print(Doctor.doctor[selectedIndex].email)
        
        dNameLabel.text = Doctor.doctor[selectedIndex].name
        dEmailLabel.text = Doctor.doctor[selectedIndex].email
        dPhoneLabel.text = String(Doctor.doctor[selectedIndex].phone)
        
        
        datePickerLabel?.datePickerMode = .dateAndTime
               datePickerLabel?.minimumDate = Date.calculateData(day: 1, month: 1, year: 2020, hour: 0, minute: 0)
               datePickerLabel?.maximumDate = Date.calculateData(day: 31, month: 1, year: 2021, hour: 0, minute: 0)
    }
    
   func setUpElements() {
   
       // Hide the error label
     
    
   
       // Style the elements
     Utilities.styleTextField(uNameTxtField)
     Utilities.styleTextField(uEmailTxtField)
     Utilities.styleTextField(uPhoneTxtField)
     Utilities.styleTextField(uGenderTxtField)
    
     Utilities.styleTextField(dateLabel)
     Utilities.styleTextField(timeLabel)
     Utilities.styleFilledButton(bookButton)
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
    
    
    @IBAction func BookAppointment(_ sender: UIButton) {
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                             // second step is context
//                          
//                      let managedContext = appDelegate.persistentContainer.viewContext
//                      print("--------------------start---------------------")
//                      
//        //              let username = UserNameTextField.text
//        //              let password = PasswordTextField.text
//        //              let Email = EmailTextField.text
//        //              let Phone = Int(PhoneNmberTextField.text ?? "0" ) ?? 0
//        //
//        //              let firstName = firstnametxt.text
//        //              let lastName = lastnametxt.text
//                
//                let dname = dNameLabel.text
//                let uname = uNameTxtField.text
//                let uemail = uEmailTxtField.text
    }
}

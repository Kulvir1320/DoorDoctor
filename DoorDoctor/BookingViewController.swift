//
//  BookingViewController.swift
//  DoorDoctor
//
//  Created by Alisha Thind on 2020-04-14.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import CoreData

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
    var bookingModal: [BookingModal]?
    
    var del_DListVC : doctorListViewController?
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()
         setUpElements()
        // Do any additional setup after loading the view.
        print(Doctor.doctor[selectedIndex].name)
        print(Doctor.doctor[selectedIndex].phone)
        print(Doctor.doctor[selectedIndex].email)
        bookingModal = [BookingModal]()
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                             // second step is context
                          
                      let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let uName = uNameTxtField.text
        let uEmail = uEmailTxtField.text
        let uPhone = Int(uPhoneTxtField.text ?? "0") ?? 0
        let uGender = uGenderTxtField.text
        let uDate = dateLabel.text
        let uTime = timeLabel.text
        let dName = dNameLabel.text
        
        let b = BookingModal(dName: dName!, uName: uName!, Email: uEmail!, Gender: uGender!, Phone: uPhone, uDate: uDate!, uTime: uTime!)
        bookingModal?.append(b)
        
                      print("--------------------start---------------------")
        for book in bookingModal! {
                   let bookEntity = NSEntityDescription.insertNewObject(forEntityName: "Appointments", into: managedContext)
            
               
             bookEntity.setValue(book.dName, forKey: "dName")
             bookEntity.setValue(book.uDate, forKey: "uDate")
             bookEntity.setValue(book.Email, forKey: "uEmail")
             bookEntity.setValue(book.Gender, forKey: "uGender")
             bookEntity.setValue(book.uName, forKey: "uName")
             bookEntity.setValue(book.Phone, forKey: "uPhone")
             bookEntity.setValue(book.uTime, forKey: "uTime")
                   
                   // save context
                   do {
                       try managedContext.save()
                    let alert = UIAlertController(title: "Successfully", message: "You Appointment has Booked", preferredStyle: UIAlertController.Style.alert)

                                                                                     // add an action (button)
                                       alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                                     // show the alert
                                       self.present(alert, animated: true, completion: nil)
                    uNameTxtField.text = ""
                    uEmailTxtField.text = ""
                    uPhoneTxtField.text = ""
                    uGenderTxtField.text = ""
                    dateLabel.text = ""
                    timeLabel.text = ""
                   } catch {
                       print(error)
                   }
               }
        loadCoreData()
          
    }
    
    func loadCoreData() {
        bookingModal = [BookingModal]()
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // second step is context
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Appointments")
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if results is [NSManagedObject] {
                for result in results as! [NSManagedObject] {
//                    let title = result.value(forKey: "title") as! String
//                    let author = result.value(forKey: "author") as! String
//                    let pages = result.value(forKey: "pages") as! Int
//                    let year = result.value(forKey: "year") as! Int
                    let dname = result.value(forKey: "dName") as! String
                    let uname = result.value(forKey: "uName") as! String
                    let uEmail = result.value(forKey: "uEmail") as! String
                    let uGender = result.value(forKey: "uGender") as! String
                    let uDate = result.value(forKey: "uDate") as! String
                    let uPhone = result.value(forKey: "uPhone") as! Int
                    let uTime = result.value(forKey: "uTime") as! String
                    
                    bookingModal?.append(BookingModal(dName: dname, uName: uname, Email: uEmail, Gender: uGender, Phone: uPhone, uDate: uDate, uTime: uTime))
                    print(dname)
                    print(uname)
                    print(uEmail)
                    print(uGender)
                    print(uDate)
                    print(uPhone)
                    print(uTime)
                }
                
            }
        } catch {
            print(error)
        }
        
    }
    
}

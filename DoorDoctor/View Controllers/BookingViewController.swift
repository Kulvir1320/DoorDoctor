//
//  BookingViewController.swift
//  DoorDoctor
//
//  Created by Alisha Thind on 2020-04-14.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications



class BookingViewController: UIViewController  {

    @IBOutlet var dateLabel: UITextField!
    @IBOutlet var timeLabel: UITextField!
    
    
    @IBOutlet weak var dlabel: UILabel!
    
    @IBOutlet weak var tlabel: UILabel!
    
    @IBOutlet var datePickerLabel: UIDatePicker!
    
    
    @IBOutlet var dNameLabel: UILabel!
    @IBOutlet var dPhoneLabel: UILabel!
    @IBOutlet var dEmailLabel: UILabel!
    
    @IBOutlet var uNameTxtField: UITextField!
    @IBOutlet var uEmailTxtField: UITextField!
    
    @IBOutlet var uAgeTxtField: UITextField!
    @IBOutlet var uGenderTxtField: UITextField!
    
    @IBOutlet var bookButton: UIButton!
    var bookingModal: [BookingModal]?
    var ph: Int?
    var uTime: String?
    var uDate: String?

    
    var del_DListVC : doctorListViewController?
    var selectedIndex = -1

    override func viewDidLoad() {
        
       
        super.viewDidLoad()
        
        datePickerLabel.isHidden = true
               
               
               let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewtapped))
                            self.view.addGestureRecognizer(tapGesture)
        
        let tgdate = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        dlabel.addGestureRecognizer(tgdate)
        
        let tgtime = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        tlabel.addGestureRecognizer(tgtime)
    
         setUpElements()
        // Do any additional setup after loading the view.
        print(Doctor.doctor[selectedIndex].name)
        print(Doctor.doctor[selectedIndex].phone)
        print(Doctor.doctor[selectedIndex].email)
        bookingModal = [BookingModal]()
        dNameLabel.text = Doctor.doctor[selectedIndex].name
        dEmailLabel.text = Doctor.doctor[selectedIndex].email
        dPhoneLabel.text = String(Doctor.doctor[selectedIndex].phone)
        
        
        
        
         UNUserNotificationCenter.current().delegate = self
        
        datePickerLabel?.datePickerMode = .dateAndTime
               datePickerLabel?.minimumDate = Date.calculateData(day: 1, month: 1, year: 2020, hour: 0, minute: 0)
               datePickerLabel?.maximumDate = Date.calculateData(day: 31, month: 1, year: 2021, hour: 0, minute: 0)
        
    }
    
    
    @objc func viewtapped()
    {
        uNameTxtField.resignFirstResponder()
        uEmailTxtField.resignFirstResponder()
        uAgeTxtField.resignFirstResponder()
        uGenderTxtField.resignFirstResponder()
//        dateLabel.resignFirstResponder()
//        timeLabel.resignFirstResponder()
      
    }
    
    @objc func labelTapped() {
        datePickerLabel.isHidden = false
    }
    
   func setUpElements() {
   
       // Hide the error label
     
    
   
       // Style the elements
     Utilities.styleTextField(uNameTxtField)
     Utilities.styleTextField(uEmailTxtField)
     Utilities.styleTextField(uAgeTxtField)
     Utilities.styleTextField(uGenderTxtField)
    
//     Utilities.styleTextField(dateLabel)
//     Utilities.styleTextField(timeLabel)
     Utilities.styleFilledButton(bookButton)
    
    Utilities.styleTextLabel(dlabel)
    Utilities.styleTextLabel(tlabel)
    
    
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
        
        dlabel?.text = " \(sender.date.getDayMonthYearHourMinuteSecond().day)-\(sender.date.getDayMonthYearHourMinuteSecond().month)-\(sender.date.getDayMonthYearHourMinuteSecond().year)"
        tlabel.text = " \(sender.date.getDayMonthYearHourMinuteSecond().hour):\(sender.date.getDayMonthYearHourMinuteSecond().minute)"
    }
    
    
    @IBAction func BookAppointment(_ sender: UIButton) {
        
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    
       let managedContext = appDelegate.persistentContainer.viewContext
                
                
                let uName = uNameTxtField.text
                let age = uAgeTxtField.text
                let uAge = Int(uAgeTxtField.text ?? "0") ?? 0
                let uGender = uGenderTxtField.text
                var udate = dlabel.text
                let utime = tlabel.text
                let dName = dNameLabel.text
                if(uName == "" || age == ""  || uGender == "" || udate == "" || utime == ""){
                    let alert = UIAlertController(title: "Empty!!", message: "All fields are required for Registration", preferredStyle: UIAlertController.Style.alert)
                   
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    self.present(alert, animated: true, completion: nil)
                    
                    } else {
                 
                     let fetchRequest1 = NSFetchRequest<NSFetchRequestResult>(entityName: "Appointments")
                   
                            do {
                                let results = try managedContext.fetch(fetchRequest1)
                                if results is [NSManagedObject] {
                                    for result in results as! [NSManagedObject] {
              
                                     uDate = result.value(forKey: "uDate") as! String
                                     uTime = result.value(forKey: "uTime") as! String
                                    print(uTime)
                                    }
                                    
                                }
                            } catch {
                                print(error)
                            }
                    if (uTime == utime && uDate == udate ){
                        let alert = UIAlertController(title: "Opps! ", message: "You are already booked at this time ", preferredStyle: UIAlertController.Style.alert)

                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                            self.present(alert, animated: true, completion: nil)
                        
                    }else{
                   let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
                
                               do {

                                    print("---Data inside the database ---")
      
                                   let results = try managedContext.fetch(fetchRequest)
                                   if results is [NSManagedObject] {
                                       for result in results as! [NSManagedObject] {

        
                                        ph = result.value(forKey: "phone") as! Int


                                        print("end of row------\n")
      

                                       }
                                   }
                               } catch {
                                   print(error)
                               }
                
                
                        let b = BookingModal(dName: dName!, uName: uName!, Age : uAge, Gender: uGender!, Phone: ph!, uDate: udate!, uTime: utime!)
                bookingModal?.append(b)
                        
                        let center = UNUserNotificationCenter.current()
                               
                               let content = UNMutableNotificationContent()
                               content.title = "DoorDoctor Reminder"
                               content.body = "you have booked your appointment with \(dNameLabel.text!) at \(tlabel.text!) on \(dlabel.text!)"
                               content.sound = .default
                               content.badge = 1
                        
                           let calendar = Calendar.current
                                  let components = DateComponents(year: 2020, month: 04, day: 22, hour: 17, minute: 00) // Set the date here when you want Notification
                                  let date = calendar.date(from: components)
                                  let comp2 = calendar.dateComponents([.year,.month,.day,.hour,.minute], from: date!)
                                  let trigger = UNCalendarNotificationTrigger(dateMatching: comp2, repeats: false)

                               let tigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
                               let request = UNNotificationRequest(identifier: "reminder", content: content, trigger: tigger)
                               center.add(request) { (error) in
                                   print("Erorr =\(error?.localizedDescription ?? "error local notification") " )
                               }
                
                              print("--------------------start---------------------")
                for book in bookingModal! {
                           let bookEntity = NSEntityDescription.insertNewObject(forEntityName: "Appointments", into: managedContext)
                    
                       
                     bookEntity.setValue(book.dName, forKey: "dName")
                     bookEntity.setValue(book.uDate, forKey: "uDate")
                     bookEntity.setValue(book.Age, forKey: "uAge")
                     bookEntity.setValue(book.Gender, forKey: "uGender")
                     bookEntity.setValue(book.uName, forKey: "uName")
                     bookEntity.setValue(book.Phone, forKey: "uPhone")
                     bookEntity.setValue(book.uTime, forKey: "uTime")
                           
    
                           do {
                               try managedContext.save()
                            let alert = UIAlertController(title: "Successfully", message: "You Appointment has Booked", preferredStyle: UIAlertController.Style.alert)
                            
                             alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            
                            self.present(alert, animated: true, completion: nil)
                            uNameTxtField.text = ""
                            uAgeTxtField.text = ""
                            uGenderTxtField.text = ""
                            dlabel.text = ""
                            tlabel.text = ""
                           } catch {
                               print(error)
                           }
                       }
                loadCoreData()
                }
                }
        
       
     func userNotificationCenter(_ center: UNUserNotificationCenter,
                                    willPresent notification: UNNotification,
                                    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
            completionHandler([.alert, .sound])

        }
          
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

                    let dname = result.value(forKey: "dName") as! String
                    let uname = result.value(forKey: "uName") as! String
                    let uage = result.value(forKey: "uAge") as! Int
                    let uGender = result.value(forKey: "uGender") as! String
                    let uDate = result.value(forKey: "uDate") as! String
                    let uPhone = result.value(forKey: "uPhone") as! Int
                    let uTime = result.value(forKey: "uTime") as! String
                    
                    bookingModal?.append(BookingModal(dName: dname, uName: uname, Age: uage, Gender: uGender, Phone: uPhone, uDate: uDate, uTime: uTime))
                    print(dname)
                    print(uname)
                    print(uage)
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
    
    
    
    @IBAction func datetouchdown(_ sender: Any) {
        
        datePickerLabel.isHidden = false
    }
    
    @IBAction func timetouchdown(_ sender: Any) {
        
        datePickerLabel.isHidden = false
    }
    
    
    @IBAction func dateeditend(_ sender: Any) {
        datePickerLabel.isHidden = true
    }
    
    
    @IBAction func timeeditend(_ sender: Any) {
        datePickerLabel.isHidden = true
    }
    
    
}

extension  BookingViewController: UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound,.badge])
    }
    
    
}

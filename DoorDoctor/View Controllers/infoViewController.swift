//
//  infoViewController.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-16.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import CoreData

class infoViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
   
    

    
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var firstlastNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var username: String?
    var firstname: String?
    var lastname: String?
    var email: String?
    var phone: Int?
    //var appointmentlist: [AppointmentList]?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 120
        //appointmentlist = [AppointmentList]()
         info()
        appointmentInfo()
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppointmentList.appointList.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! infoCustomCellTableViewCell
        cell.doctorNameLabel.text = AppointmentList.appointList[indexPath.row].dname
        cell.dateLabel.text = AppointmentList.appointList[indexPath.row].dDate
        cell.timeLabel.text = AppointmentList.appointList[indexPath.row].dTime
        return cell
       }
    
    // user info
    func info(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                      // second step is context
                   
               let managedContext = appDelegate.persistentContainer.viewContext

                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        
        fetchRequest.predicate = NSPredicate(format: "username = %@", userAccount.loggedInUser)
        //
                       do {

                            print("---Data inside the database ---")
                        var count = 0
                           let results = try managedContext.fetch(fetchRequest)
                           if results is [NSManagedObject] {
                               for result in results as! [NSManagedObject] {

                                print("row---\(count)\n")
                                username = result.value(forKey: "username") as! String
                               email = result.value(forKey: "email") as! String
                               firstname = result.value( forKey: "firstname") as! String
                                 lastname = result.value( forKey: "lastname") as! String
//                               let pw = result.value( forKey: "password") as! String
                                phone = result.value(forKey: "phone") as! Int

//                                print("\(un)--\(email)--\(pw)--\(fn)--\(ln)--\(ph)")
                                print(username)
                                


                                print("end of row------\n")
                                count = count + 1

                               }
                           }
                       } catch {
                           print(error)
                       }

        userNameLabel.text = username
        firstlastNameLabel.text = "\(firstname!) \(lastname!)"
        emailLabel.text = email
        phoneLabel.text = String(phone!)
        
        
    }
    func appointmentInfo(){
        AppointmentList.appointList = [AppointmentList]()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
          
        let FetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Appointments")
        
//        if performSearch{
//
//        FetchReq.predicate = NSPredicate(format: "title contains[c] %@", noteToSearch!)
                
                
//            }else{
        FetchReq.returnsObjectsAsFaults = false
                FetchReq.predicate = NSPredicate(format: "uPhone = %@", String(phone!))
//            }
            
            
            
             
            do{
                
                let results = try context.fetch(FetchReq)
               // appointmentlist = result as! [AppointmentList]
               if results is [NSManagedObject] {
                for result in results as! [NSManagedObject] {
                    
                   let dname = result.value(forKey: "dName") as! String
                    let uname = result.value(forKey: "uName") as! String
                    let uage = result.value(forKey: "uAge") as! Int
                    let uGender = result.value(forKey: "uGender") as! String
                    let uDate = result.value(forKey: "uDate") as! String
                    let uPhone = result.value(forKey: "uPhone") as! Int
                    let uTime = result.value(forKey: "uTime") as! String
                    let a = AppointmentList(dname: dname, dDate: uDate, dTime: uTime)
                    AppointmentList.appointList.append(a)
                    print(dname)
                    print(uDate)
                    print(uTime)
                    
                }
                
            }
                
//                print(AppointmentList.appointList.)
//                notes = result as! [NSManagedObject]
            }
            catch{
                print(error)
            }
        tableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  signupViewController.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-07.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import CoreData

class signupViewController: UIViewController {
    
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhoneNmberTextField: UITextField!
    
    @IBOutlet weak var lastnametxt: UITextField!
    @IBOutlet weak var firstnametxt: UITextField!
    @IBOutlet weak var signup: UIButton!
    
    @IBOutlet weak var errorlabel: UILabel!
    var phn: Int?
    var un: String?
    var useraccount: [userAccount]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
          useraccount = [userAccount]()
    }
    func setUpElements() {
      
          // Hide the error label
        
        errorlabel.alpha = 0
      
          // Style the elements
        Utilities.styleTextField(UserNameTextField)
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PhoneNmberTextField)
        Utilities.styleFilledButton(signup)
        Utilities.styleTextField(firstnametxt)
        Utilities.styleTextField(lastnametxt)
      }

    
     @IBAction func SignUpButton(_ sender: UIButton) {
//        clearCoreData()
        // create an instance of app delegate
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               // second step is context
            
        let managedContext = appDelegate.persistentContainer.viewContext
        print("--------------------start---------------------")
        
        let username = UserNameTextField.text as! String
        let password = PasswordTextField.text as! String
        let Email = EmailTextField.text as! String
        let Phone = Int(PhoneNmberTextField.text ?? "0" ) ?? 0
        
        let firstName = firstnametxt.text as! String
        let lastName = lastnametxt.text as! String
        
       
       
        let u = userAccount(username: username, password: password,firstname: firstName, lastname: lastName, phone: Phone,Email: Email )
        useraccount?.append(u)
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        
        var phonePresent = false
        var unPresent = false
        if(username == "" || password == "" || firstName == "" || lastName == "" || Email == "" || Phone == nil){
       
            
            let alert = UIAlertController(title: "OPPs! Something went ", message: "All fields are required for Registration", preferredStyle: UIAlertController.Style.alert)

                                                                                  // add an action (button)
                          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                                  // show the alert
                          self.present(alert, animated: true, completion: nil)
        }
        else {
         do {
    
                let results = try managedContext.fetch(fetchRequest)
                if results is [NSManagedObject] {
                for result in results as! [NSManagedObject] {
        
                un = result.value(forKey: "username") as! String
                phn = result.value(forKey: "phone") as! Int
        
                                print("un\(un)")
                                print("phn\(phn)")
     
                                
                if(Int(PhoneNmberTextField.text!) == phn){
                                    
                                    phonePresent = true
                                    
                                }
            if(UserNameTextField.text! == un){
                                    
                                    unPresent = true
                                    
                                    }
                                
                                
                        }
            }
         }
         catch {
                print(error)
                }
        
                                
        print(phonePresent)
        print(unPresent)
        if ((phonePresent) || (unPresent)){
            
            let alert = UIAlertController(title: "OPPS! something went ", message: "Sorry you are already registered.", preferredStyle: UIAlertController.Style.alert)

                                                                        // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                        // show the alert
                self.present(alert, animated: true, completion: nil)
            
            
            
        }else{
            
            do {
                for user in useraccount!{
                let userEntity = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: managedContext)
                    userEntity.setValue(user.Email, forKey: "email")
                       userEntity.setValue(user.firstname, forKey: "firstname")
                    userEntity.setValue(user.lastname, forKey: "lastname")
                    userEntity.setValue(user.password, forKey: "password")
                    userEntity.setValue(user.phone, forKey: "phone")
                    userEntity.setValue(user.username, forKey: "username")
                       
                      
                       print("-----------------------------end---------------")
                
                try   managedContext.save()

                        let alert = UIAlertController(title: "Congratulations", message: " You are now member of DoorDoctor", preferredStyle: UIAlertController.Style.alert)

                                                                  // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                  // show the alert
                    self.present(alert, animated: true, completion: nil)
                     UserNameTextField.text = ""
                     PasswordTextField.text = ""
                     EmailTextField.text = ""
                     PhoneNmberTextField.text = ""
                     firstnametxt.text = ""
                     lastnametxt.text = ""
                    print("Data is Saved")
                    
                }
                
            }
            catch {
                print(error)
              print("error")
            }
//            }
        }
            
        // reading database
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
//
               do {

                    print("---Data inside the database ---")
                var count = 0
                   let results = try managedContext.fetch(fetchRequest)
                   if results is [NSManagedObject] {
                       for result in results as! [NSManagedObject] {

                        print("row---\(count)\n")
                        let un = result.value(forKey: "username") as! String
                        let email = result.value(forKey: "email") as! String
                        let fn = result.value( forKey: "firstname") as! String
                         let ln = result.value( forKey: "lastname") as! String
                       let pw = result.value( forKey: "password") as! String
                        let ph = result.value(forKey: "phone") as! Int

                        print("\(un)--\(email)--\(pw)--\(fn)--\(ln)--\(ph)")



                        print("end of row------\n")
                        count = count + 1

                       }
                   }
               } catch {
                   print(error)
               }

        
        }
     }
    func clearCoreData() {
           // create an instance of app delegate
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           // second step is context
           let managedContext = appDelegate.persistentContainer.viewContext
           // create a fetch request
           let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
           
           fetchRequest.returnsObjectsAsFaults = false
           
           do {
               let results = try managedContext.fetch(fetchRequest)
               for managedObjects in results {
                   if let managedObjectData = managedObjects as? NSManagedObject {
                       managedContext.delete(managedObjectData)
                   }
               }
           } catch {
               print(error)
           }
           
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

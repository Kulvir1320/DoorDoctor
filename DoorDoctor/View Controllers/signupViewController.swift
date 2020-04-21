//
//  signupViewController.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-07.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth
import Firebase
import FirebaseFirestore

class signupViewController: UIViewController {
    
//    @IBOutlet weak var UserNameTextField: UITextField!
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
        
        self.navigationItem.title = "SignUp"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewtapped))
        self.view.addGestureRecognizer(tapGesture)
          useraccount = [userAccount]()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
    }
    
    @objc func viewtapped()
    {
//        UserNameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
        EmailTextField.resignFirstResponder()
        PhoneNmberTextField.resignFirstResponder()
    }
    func setUpElements() {
      
          // Hide the error label
        
        errorlabel.alpha = 0
      
          // Style the elements
    
        Utilities.styleTextField(PasswordTextField)
        Utilities.styleTextField(EmailTextField)
        Utilities.styleTextField(PhoneNmberTextField)
        Utilities.styleFilledButton(signup)
        Utilities.styleTextField(firstnametxt)
        Utilities.styleTextField(lastnametxt)
      }

    
     @IBAction func SignUpButton(_ sender: UIButton) {
        
        
        let email = EmailTextField.text
        let password = PasswordTextField.text
        let fname = firstnametxt.text
        let lname = lastnametxt.text
        let phone = PhoneNmberTextField.text
        let pInt = Int(PhoneNmberTextField.text!) ?? 0
        
        
        let error = validateFeilds()
        
        if error != nil{
            showError(message: error!)
            print("therer is erroe with the feilds////////")
        }else{
            
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                if err != nil{
                    print(err?.localizedDescription)
                    print("there is error while create user.//////////")
                }else{
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["firstname": fname!,"lastname": lname!, "phone": phone!,"uid": result!.user.uid]) { (error) in
                        if error != nil{
                            print("///////////////////")
                        }
                        else{
                            self.showAlert(title: "Congratulations", message: "You are succesfully registered")
                            
                          
                        }
                    }
                    
                    self.saveCoreData(email: email!, password: password!, firstname: fname!, lastname: lname!, phone: pInt)
                    
                    self.transition()
                    
                    
                }
            }
            
        }

       
        

        
     }
    
    func showError(message: String){
        errorlabel.alpha = 1
        errorlabel.text = message
        
    }
    
    func transition()  {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as? ViewController

                       self.view.window?.rootViewController = vc
                       self.view.window?.makeKeyAndVisible()
    }
    
    
    func validateFeilds() -> String? {
        
        if firstnametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastnametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            EmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            PhoneNmberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill all the required feilds"
        }
        return nil
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
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
    
    func saveCoreData(email: String, password: String, firstname: String, lastname: String,phone: Int) {
        
        print("inside save core data.....................")
        
        clearCoreData()
        
         let appDelegate = UIApplication.shared.delegate as! AppDelegate

                let managedContext = appDelegate.persistentContainer.viewContext
        //        print("--------------------start---------------------")
                
        let u = userAccount(password: password, firstname: firstname, lastname: lastname, phone: phone, Email: email)
                
                useraccount?.append(u)
                
                 let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")

                    do {
                        for user in useraccount!{
                        let userEntity = NSEntityDescription.insertNewObject(forEntityName: "UserInfo", into: managedContext)
                            userEntity.setValue(user.Email, forKey: "email")
                               userEntity.setValue(user.firstname, forKey: "firstname")
                            userEntity.setValue(user.lastname, forKey: "lastname")
                            userEntity.setValue(user.password, forKey: "password")
                            userEntity.setValue(user.phone, forKey: "phone")
                           

                        try   managedContext.save()

                        }

                    }
                    catch {
                        print(error)
                      print("error")
                    }
        
         do {

                                    print("---Data inside the database ---")
                                var count = 0
                                   let results = try managedContext.fetch(fetchRequest)
                                   if results is [NSManagedObject] {
                                    print("INside if")
                                       for result in results as! [NSManagedObject] {

                                        print("row---\(count)\n")
                                       
                                  let     email = result.value(forKey: "email") as! String
                                    let   firstname = result.value( forKey: "firstname") as! String
                                      let   lastname = result.value( forKey: "lastname") as! String
        //                               let pw = result.value( forKey: "password") as! String
                                     let   phone = result.value(forKey: "phone") as! Int

        //                                print("\(un)--\(email)--\(pw)--\(fn)--\(ln)--\(ph)")
        //                                print(username)
                                        print("phone --------\(phone)")
                                        print("email--------\(email)")
                                        print("firstname-------\(firstname)")


                                        print("end of row------\n")
                                        count = count + 1

                                       }
                                   }
                               } catch {
                                print("error")
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

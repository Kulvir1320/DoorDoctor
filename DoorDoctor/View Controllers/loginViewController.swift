//
//  loginViewController.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-07.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import CoreData
import FirebaseAuth

class loginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var login: UIButton!
//    let button = UIButton(type: .custom)
    
    @IBOutlet weak var error: UILabel!
    var un: String?
    var pass: String?
    var useraccount: [userAccount]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewtapped))
              self.view.addGestureRecognizer(tapGesture)
        
        self.navigationItem.title = "LogIn"
//
        // Do any additional setup after loading the view.
         useraccount = [userAccount]()
         setUpElements()
        
        usernameTextField.text = "alisha@gmail.com"
        passwordTextField.text = "Alisha123"
    }
    
//
    
//    func addLeftImageTo(textField: UITextField, andImage img: UIImage) {
 
    

    
    
    func setUpElements() {
        
        // Hide the error label
        error.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(login)
        
    }
    @objc func viewtapped()
    {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
      
    }
     
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: nil)
    }
    
    
    @IBAction func LoginButton(_ sender: UIButton) {
        
        let email = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.CheckForUserNameAndPasswordMatch(email: email!, password: password!)
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil{
                self.showAlert(title: "OOPS!!", message: "Your password or email is incorrect.")
            }else{
                self.loadHomeScreen()
                
                 userAccount.loggedInUser = email!
            
            }
        }
        
        
      
     //   print("login")

      //  let username = usernameTextField.text
     //   let password = passwordTextField.text

//        CheckForUserNameAndPasswordMatch(email: email!, password: password!)
      //  if(username == "" || password == ""){

     //    let alert = UIAlertController(title: "OPPs! Something went wrong ", message: "All fields are mandatory for Login", preferredStyle: UIAlertController.Style.alert)

       //     alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        //    self.present(alert, animated: true, completion: nil)
      //  }
     //   else {

      //      CheckForUserNameAndPasswordMatch(username: username!, password: password!)
      //      usernameTextField.text = ""
      //      passwordTextField.text = ""
      //  }
    
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    func loadHomeScreen(){

      //  if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeviewController") as? hometabViewController {
       //     if let navigator = navigationController {
         //       navigator.pushViewController(viewController, animated: true)
          //  }
       // }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "homeviewController") as? hometabViewController

        self.view.window?.rootViewController = vc
        self.view.window?.makeKeyAndVisible()
    }

    
    func CheckForUserNameAndPasswordMatch( email: String, password : String)
    { print("check")
        let app = UIApplication.shared.delegate as! AppDelegate

        let context = app.persistentContainer.viewContext

        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")

        let predicate = NSPredicate(format: "email = %@", email)
        print(email)

        fetchrequest.predicate = predicate
        do
        {
            let result = try context.fetch(fetchrequest) as NSArray

            if result.count>0
            {
                let objectentity = result.firstObject as! UserInfo
                print("inside object entity")

                if objectentity.email == email && objectentity.password == password
                {
                    print("inside object entity load home")
//                    loadHomeScreen()
                    userAccount.loggedInUser = email
                    let alert = UIAlertController(title: "Welcome \(email)", message: " You are successfully login", preferredStyle: UIAlertController.Style.alert)

                                                                                                 // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                                                 // show the alert
                    self.present(alert, animated: true, completion: nil)

                                                      print("You are login Successfully")
                }
                else
                {

        let alert = UIAlertController(title: "OPPS! Something went wrong", message: "Username or Password is not Registered", preferredStyle: UIAlertController.Style.alert)
                    //
                                                                                                            // add an action (button)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                                                            // show the alert
                self.present(alert, animated: true, completion: nil)
                    //                                  print("Please check your fields")
                    print("Wrong username or password !!!---")
                }
            }
        }

        catch
        {
            let fetch_error = error as NSError
            print("error", fetch_error.localizedDescription)
        }

    }
    
    }
    


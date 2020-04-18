//
//  loginViewController.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-07.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import CoreData

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
//
        // Do any additional setup after loading the view.
         useraccount = [userAccount]()
         setUpElements()
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
     
    
    
    
    @IBAction func LoginButton(_ sender: UIButton) {
         
      
        print("login")

//
        let username = usernameTextField.text
        let password = passwordTextField.text

//
//
//
//
        CheckForUserNameAndPasswordMatch(username: username!, password: password!)
        if(username == "" || password == ""){

            let alert = UIAlertController(title: "OPPs! Something went wrong ", message: "All fields are mandatory for Login", preferredStyle: UIAlertController.Style.alert)

                                                                    // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                    // show the alert
            self.present(alert, animated: true, completion: nil)
        }
////
        else {

            
//
//                                                                                        // add
            CheckForUserNameAndPasswordMatch(username: username!, password: password!)
            usernameTextField.text = ""
            passwordTextField.text = ""
        }
    
    }
    func loadHomeScreen(){
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let loggedInViewController = storyBoard.instantiateViewController(withIdentifier: "homeviewController") as! hometabViewController
//        self.present(loggedInViewController, animated: true, completion: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "homeviewController") as! hometabViewController
//        navigationController?.pushViewController(vc, animated: true)
        // Safe Push VC
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeviewController") as? hometabViewController {
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    
    func CheckForUserNameAndPasswordMatch( username: String, password : String)
    {
        let app = UIApplication.shared.delegate as! AppDelegate

        let context = app.persistentContainer.viewContext

        let fetchrequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")

        let predicate = NSPredicate(format: "username = %@", username)

        fetchrequest.predicate = predicate
        do
        {
            let result = try context.fetch(fetchrequest) as NSArray

            if result.count>0
            {
                let objectentity = result.firstObject as! UserInfo

                if objectentity.username == username && objectentity.password == password
                {
                    loadHomeScreen()
                    userAccount.loggedInUser = username
                    let alert = UIAlertController(title: "Welcome \(username)", message: " You are successfully login", preferredStyle: UIAlertController.Style.alert)
                    
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
    


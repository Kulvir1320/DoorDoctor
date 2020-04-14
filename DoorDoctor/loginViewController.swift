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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        passwordTextField.leftViewMode = .unlessEditing
//        button.setImage(UIImage(named: "eyeclose"), for: .normal)
//        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -24, bottom: 5, right: 15)
//        button.frame = CGRect(x: CGFloat(passwordTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25))
//        button.addTarget(self, action: #selector(self.btnPasswordVisibilityClicked), for: .touchUpInside)
//        passwordTextField.leftView = button
//        passwordTextField.rightViewMode = .always
        
//        let userImage = UIImage(named: "usericon")
//        addLeftImageTo(textField: usernameTextField, andImage: userImage!)
//
//        let passImage = UIImage(named: "showpass")
//               addLeftImageTo(textField: passwordTextField, andImage: passImage!)

        // Do any additional setup after loading the view.
         setUpElements()
    }
    
//    @IBAction func btnPasswordVisibilityClicked(_ sender: Any) {
//        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
//        if (sender as! UIButton).isSelected {
//            self.passwordTextField.isSecureTextEntry = false
//            button.setImage(UIImage(named:"openeye.png"), for: .normal)
//        } else {
//             self.passwordTextField.isSecureTextEntry = true
//                       button.setImage(UIImage(named:"eyeclose.png"), for: .normal)
//        }
//    }
    
    
//    func addLeftImageTo(textField: UITextField, andImage img: UIImage) {
//
//        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 20, height: 20))
//        leftImageView.image = img
//        textField.leftView = leftImageView
//        textField.leftViewMode = .always
//    }
////
    
    
    
    
    
    
    
    func setUpElements() {
        
        // Hide the error label
        error.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(usernameTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(login)
        
    }
    
    
    
    
    @IBAction func LoginButton(_ sender: UIButton) {
      
        print("login")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               // second step is context

        let managedContext = appDelegate.persistentContainer.viewContext

        let username = usernameTextField.text
        let password = passwordTextField.text



        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        
        

        do {

                       let results = try managedContext.fetch(fetchRequest)
                       if results is [NSManagedObject] {
                        for result in results as! [NSManagedObject] {

                           un = result.value(forKey: "username") as! String
                          pass = result.value(forKey: "password") as! String
                            print(un)
                            print(pass)

                        }





            }

        }
        catch {
                       print(error)
                       }
        
        if(username == "" || password == ""){
           
            let alert = UIAlertController(title: "OPPs! Something went wrong ", message: "All fields are mandatory for Login", preferredStyle: UIAlertController.Style.alert)

                                                                    // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                    // show the alert
            self.present(alert, animated: true, completion: nil)
        }
//
        else {
        if (un == username && pass == password) {
            loadHomeScreen()
            
            let alert = UIAlertController(title: "Welcome \(username!)", message: " You are successfully login", preferredStyle: UIAlertController.Style.alert)

                                                                             // add an action (button)
                               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                             // show the alert
                               self.present(alert, animated: true, completion: nil)

                                  print("You are login Successfully")
            

                              }
                              else {
            let alert = UIAlertController(title: "OPPS! Something went wrong", message: "Username or Password is not Registered", preferredStyle: UIAlertController.Style.alert)

                                                                                        // add an action (button)
                                          alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                                                                                        // show the alert
                                          self.present(alert, animated: true, completion: nil)
                                  print("Please check your fields")
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
    
}

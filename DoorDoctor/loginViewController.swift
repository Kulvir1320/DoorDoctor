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
    
    @IBOutlet weak var error: UILabel!
    var un: String?
    var pass: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         setUpElements()
    }
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
//
//
        if (un == username && pass == password) {

                                  print("you are login successfully")
            loadHomeScreen()

                              }
                              else {
                                  print("check your fields")
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

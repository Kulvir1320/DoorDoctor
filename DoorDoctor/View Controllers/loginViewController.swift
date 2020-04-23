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
        
        usernameTextField.text = "evneet123@gmail.com"
        passwordTextField.text = "evneet123"
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
        
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil{
                self.showAlert(title: "OOPS!!", message: "Your password or email is incorrect.")
            }else{
                self.CheckForUserNameAndPasswordMatch(email: email!, password: password!)
                let alert : UIAlertController?
                alert = UIAlertController(title: nil, message: "Welcome...", preferredStyle: .alert)

                let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
                loadingIndicator.hidesWhenStopped = true
                loadingIndicator.style = UIActivityIndicatorView.Style.medium
                loadingIndicator.startAnimating();

                alert!.view.addSubview(loadingIndicator)
                self.present(alert!, animated: true, completion: nil)
                
                self.loadHomeScreen()
                
                 userAccount.loggedInUser = email!
               
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                
//                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LoggedInUser")
                do {
                                    
                let userEntity = NSEntityDescription.insertNewObject(forEntityName: "LoggedInUser", into: managedContext)
                userEntity.setValue(email, forKey: "email")
                                           
                try   managedContext.save()

            }
            catch {
                    print(error)
                    print("error")
                }
            
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
        UserDefaults.standard.set(usernameTextField.text!, forKey: "email")
       print( UserDefaults.standard.data(forKey: "email"))
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
    


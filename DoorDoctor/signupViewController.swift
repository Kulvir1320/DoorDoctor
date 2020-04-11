//
//  signupViewController.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-07.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

class signupViewController: UIViewController {
    
    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PhoneNmberTextField: UITextField!
    
    @IBOutlet weak var lastnametxt: UITextField!
    @IBOutlet weak var firstnametxt: UITextField!
    @IBOutlet weak var signup: UIButton!
    
    @IBOutlet weak var errorlabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpElements()
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

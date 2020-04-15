//
//  SearchRemedieVC.swift
//  DoorDoctor
//
//  Created by Evneet kaur on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

class SearchRemedieVC: UIViewController {
    
    
    @IBOutlet weak var searchRemd: UISearchBar!
    
    @IBOutlet weak var sButtonLbl: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Utilities.styleFilledButton(sButtonLbl)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func searchBA(_ sender: Any) {
    }
    
}

//
//  hometabViewController.swift
//  DoorDoctor
//
//  Created by Amanpreet Kaur on 2020-04-13.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

class hometabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let controllers = [SearchRemedieVC.self,MapVC.self,doctorListViewController.self]
//        tabBarController?.viewControllers = controllers
//
//        // Do any additional setup after loading the view.
//        tabBarController!.viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
        
//         self.navigationController?.setNavigationBarHidden(false, animated:nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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

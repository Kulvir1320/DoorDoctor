//
//  SearchRemedieVC.swift
//  DoorDoctor
//
//  Created by Evneet kaur on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit

class SearchRemedieVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var searchRemd: UISearchBar!
    
    @IBOutlet weak var sButtonLbl: UIButton!
    
    @IBOutlet var cardTableView: UITableView!
    
    var addbtn : UIBarButtonItem!
    
    let pictures: [UIImage] = [UIImage(named: "fever.jpg")!, UIImage(named: "headache.jpeg")! , UIImage(named: "CoughCold.png")!,UIImage(named: "Stomachache.jpg")!]
    let titles: [String] = ["Fever","Headache", "ColdCough", "Stomachache"]
    let descriptions: [String] = ["Fever is when a human's body temperature goes above the normal range of 36–37° Centigrade.","Headache is pain in any region of the head.This may occur on one or both sides of the head.", "ColdCough is a self-limited contagious disease that can be caused by different types of viruses.","A stomach ache is refer to cramps or a dull ache in the tummy .It's usually short-lived."]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Utilities.styleFilledButton(sButtonLbl)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as! CardCell
        
        cell.configure(picture: pictures[indexPath.row], title: titles[indexPath.row], description: descriptions[indexPath.row])
        
        
        
        return cell
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
        
        let searchtext = searchRemd.text! + " remedie"
        
        fetchVideos(remediName: searchtext)
        
        
    }
    
}

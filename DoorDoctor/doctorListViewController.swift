//
//  doctorListViewController.swift
//  DoorDoctor
//
//  Created by Alisha Thind on 2020-04-13.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import CoreData

class doctorListViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    
    
    

    var doc: [Doctor]?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        loadData()
        
        let d1 = Doctor(id: 1, name: "img1", specialist: "Gyna")
        let d2 = Doctor(id: 2, name: "img2", specialist: "fdb")
        let d3 = Doctor(id: 3, name: "img3", specialist: "thr")
        let d4 = Doctor(id: 4, name: "img4", specialist: "hyt")
        let d5 = Doctor(id: 5, name: "img5", specialist: "sr5")
        let d6 = Doctor(id: 6, name: "img6", specialist: "sr5")
        let d7 = Doctor(id: 7, name: "img7", specialist: "sr5")
        let d8 = Doctor(id: 8, name: "img8", specialist: "sr5")
        let d9 = Doctor(id: 9, name: "img9", specialist: "sr5")
        let d10 = Doctor(id: 10, name: "img10", specialist: "sr5")
        let d11 = Doctor(id: 11, name: "img11", specialist: "sr5")
        let d12 = Doctor(id: 12, name: "img12", specialist: "sr5")
        
        
        doc = [d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12]
        
        for i in doc!
        {
            Doctor.doctor.append(i)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveData), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Doctor.doctor.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! customTableViewCell
        
                cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
                cell.nameLabel.text = Doctor.doctor[indexPath.row].name
                cell.specialistLabel.text = "\(Doctor.doctor[indexPath.row].specialist)"
        
                cell.doctorImg.image = UIImage(named: "\(Doctor.doctor[indexPath.row].name).jpg")
                cell.doctorImg.layer.cornerRadius = cell.doctorImg.frame.height / 2
        
                return cell
    }
    
    @objc func saveData(){
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           let Context = appDelegate.persistentContainer.viewContext
           
           for i in doc!{
               let doctorEntity = NSEntityDescription.insertNewObject(forEntityName: "Doctors", into: Context)
               doctorEntity.setValue(i.id, forKey: "id")
               doctorEntity.setValue(i.name, forKey: "dName")
               doctorEntity.setValue(i.specialist, forKey: "specialist")
               
               
               //save context
               
               do{
                   try Context.save()
               }catch{
                   print(error)
               }
           }
       }

    
    func loadData(){
    doc = [Doctor]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let Context = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Doctors")
    do{
        let results = try Context.fetch(fetchRequest)
            if results is [NSManagedObject] {
                for result in results as! [NSManagedObject] {
                    let id = result.value(forKey: "id") as! Int
                    let name = result.value(forKey: "dName") as! String
                    let specialist = result.value(forKey: "specialist") as! String
                    
                    doc?.append(Doctor(id: id, name: name, specialist: specialist))
                    

                }
            }
        } catch {
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
    

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
}

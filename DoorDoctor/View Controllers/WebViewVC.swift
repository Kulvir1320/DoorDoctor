//
//  WebViewVC.swift
//  DoorDoctor
//
//  Created by Evneet kaur on 2020-04-22.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import WebKit

class WebViewVC: UIViewController  {
    
    var webV : WKWebView?
    
    var url = " "
    
    var alert : UIAlertController?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        webV = WKWebView(frame: self.view.frame)
        view.addSubview(webV!)
        
        alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating();

        alert!.view.addSubview(loadingIndicator)
        present(alert!, animated: true, completion: nil)
        
        
        start()
        
    }
    
   
    
    func start() {
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            self.alert?.dismiss(animated: false, completion: nil)
             let u = URL(string: self.url)!
                       let request = URLRequest(url: u)
                       self.webV!.load(request)
        }
        
//        DispatchQueue.main.async {
//       
//            let u = URL(string: self.url)!
//            let request = URLRequest(url: u)
//            self.webV!.load(request)
//        }
         
        //fetchVideos(nameOfRecipe: nameOfRecipe!)
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

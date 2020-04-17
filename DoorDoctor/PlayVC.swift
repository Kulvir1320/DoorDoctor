//
//  PlayVC.swift
//  DoorDoctor
//
//  Created by Evneet kaur on 2020-04-15.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import WebKit

class PlayVC: UIViewController {
    
    var item : Item?
    
    var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView!)
        
        start()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func start(){
//        DispatchQueue.main.async {
//            let request = URLRequest(url: URL(string: PLAY_URL + (self.item?.id.videoID)!)!)
//            
//            self.webView?.load(request)
//            
//            
//        }
        
        let seconds = 3.0
               DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                   print(self.item?.id.videoID ?? "")
                   let request = URLRequest(url: URL(string: (PLAY_URL + (self.item?.id.videoID)!))!)
                   print("request player......................",request)
                   self.webView!.load(request)
                
        }
        
        
    }

}

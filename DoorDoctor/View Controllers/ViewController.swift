//
//  ViewController.swift
//  DoorDoctor
//
//  Created by Kulvir Dhillon on 2020-04-07.
//  Copyright © 2020 Kulvir Dhillon. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var stack: UIStackView!
    @IBOutlet var videoLayer: UIView!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        playVideo()
    }
    
    
    func setUpElements() {
           
           Utilities.styleFilledButton(signupButton)
           Utilities.styleHollowButton(LoginButton)
           
       }
     func playVideo() {
            guard let path = Bundle.main.path(forResource: "Cowboy - 33318", ofType: "mp4") else {
                return
            }
            
            let player = AVPlayer(url: URL(fileURLWithPath: path))
            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.frame = self.view.bounds
               playerLayer.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
            playerLayer.videoGravity = .resizeAspectFill
            self.videoLayer.layer.addSublayer(playerLayer)
            player.play()
            videoLayer.bringSubviewToFront(signupButton)
            videoLayer.bringSubviewToFront(LoginButton)
            videoLayer.bringSubviewToFront(stack)
            
        }
    
    override func viewWillAppear(_ animated: Bool) {
        playVideo()
    }

}


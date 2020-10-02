//
//  ViewController.swift
//  LoginSampel
//
//  Created by Hakim Laoukili on 2020-09-28.
//  Copyright © 2020 Hakim Laoukili. All rights reserved.
//

import UIKit
import AVKit


class ViewController: UIViewController {
    
    var videoPlayer:AVPlayer?
    
    var vidieoPlayerLayer:AVPlayerLayer?
    
    
    @IBOutlet weak var singUpButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Setting up the viedo in the Background
        
        setUpVideo()
    }

    
    
    func setUpElements(){
        
        //Style the elemants
        Utilities.styleFilledButton(singUpButton)
        Utilities.styleHollowButton(loginButton)
        
    }
    
    func setUpVideo(){
        
        //Greating Bundle
        let bundelPath = Bundle.main.path(forResource: "NewYear", ofType: "mp4")
        
        guard bundelPath != nil else{
            return
        }
        // Greatting the URL
        let url = URL(fileURLWithPath: bundelPath!)
        
        
        //Greatting the Vidieo item
        let item = AVPlayerItem(url: url)
        
        //Greatting the Player
        videoPlayer = AVPlayer(playerItem: item)
        
        vidieoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        
        //Fixing the framme
        vidieoPlayerLayer?.frame = CGRect(x:
            -self.view.frame.size.width*1.5, y: 0, width:
            self.view.frame.size.width*4, height:
            self.view.frame.size.height)
        
        view.layer.insertSublayer(vidieoPlayerLayer!, at: 0)
        
        videoPlayer?.playImmediately(atRate: 0.3)
        
        
        
    }
}


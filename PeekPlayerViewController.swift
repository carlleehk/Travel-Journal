//
//  PeekPlayerViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/11/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PeekPlayerViewController: AVPlayerViewController {
    
    var video: Video?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let video = video{
            
            let videoURL = URL(string: video.videoData!)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            present(playerViewController, animated: true, completion: {
                playerViewController.player!.play()
            })
            
        }
        
        

        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    
    var initiatingPreviewActionController: UIViewController?
    var video: Video?
    var videoPlayer: AVPlayer? = AVPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let video = video else{
            return
        }
        
        print(video.videoData)
        let videoURL = URL(string: video.videoData!)
        videoPlayer = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = videoPlayer
        
        guard let initiatingPreviewActionController = self.initiatingPreviewActionController else {
            assert(false, "Expected initiatingPreviewActionController to be set")
            return
        }
        
        NotificationCenter.default.addObserver(self, selector: Selector(("playerDidReachEndNotificationHandler:")), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: videoPlayer!.currentItem)
        initiatingPreviewActionController.present(playerViewController, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }
    
    func playerDidReachEndNotificationHandler(notification: NSNotification){
        print("playerDidReachEndNotification")
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let video = video{
            
            let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
            //let videoURL = URL(string: video.videoData!)
            let player = AVPlayer(url: videoURL!)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = CGRect(x: 5, y: 15, width: 400, height: 400)
            //playerLayer.frame = self.view.bounds
            self.view.layer.addSublayer(playerLayer)
            player.play()
        }

        
    }*/
    

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

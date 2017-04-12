//
//  PeekViewViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 4/11/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PeekViewViewController: CoreDataViewController {

    @IBOutlet weak var image: UIImageView!
    
    var photo: Photo?
    var video: Video?
    var isVideo: Bool?
    var initiatingPreviewActionController: UIViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let photo = photo{
            image.image = UIImage(data: photo.photoData!)
        }
        
        if let video = video{
            image.image = UIImage(data: video.videoPhoto!)
        }
        
        

        // Do any additional setup after loading the view.
    }

    override var previewActionItems: [UIPreviewActionItem]{
        
       
        let deleteAction = UIPreviewAction(title: "Delete", style: .destructive) { (action, viewController) -> Void in
            
            if self.isVideo!{
                self.stack.context.delete(self.video!)
            } else{
                self.stack.context.delete(self.photo!)
            }
            print("You deleted the video")
            
            
        }
        
        if isVideo!{
            let viewAction = UIPreviewAction(title: "Play Video", style: .default) { (action, viewController) -> Void in
                print("You selected the photo")
                guard let initiatingPreviewActionController = self.initiatingPreviewActionController else {
                    assert(false, "Expected initiatingPreviewActionController to be set")
                    return
                }
                
                /*let control = self.storyboard?.instantiateViewController(withIdentifier: "peekPlayer") as! PeekPlayerViewController
                control.video = self.video
                control.initiatingPreviewActionController = initiatingPreviewActionController
                initiatingPreviewActionController.present(control, animated: true, completion: nil)*/
                
                let videoURL = URL(string: (self.video?.videoData)!)
                let player = AVPlayer(url: videoURL!)
                let playerViewController = AVPlayerViewController()
                playerViewController.player = player
                initiatingPreviewActionController.present(playerViewController, animated: true, completion: {
                    playerViewController.player!.play()
                })
            }
            
            return[viewAction, deleteAction]
        }
        
        return[deleteAction]
        
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

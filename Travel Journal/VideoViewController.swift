//
//  VideoViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/30/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class VideoViewController: ChooseScreenViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func takingVideo(_ sender: Any) {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let alertController = UIAlertController(title: "Error", message: "Video Camera is not avaliable for use, please choose other sosurce.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        } else{
            pickingVideo(sourceType: UIImagePickerControllerSourceType.camera)
        }

    }
    
    @IBAction func videoLibrary(_ sender: Any) {
        pickingVideo(sourceType: UIImagePickerControllerSourceType.photoLibrary)
    }
    
    func pickingVideo(sourceType: UIImagePickerControllerSourceType){
        let image = UIImagePickerController()
        image.sourceType = sourceType
        image.mediaTypes = [kUTTypeMovie as String]
        image.delegate = self
        present(image, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        if mediaType == kUTTypeMovie as String{
            
            let videoURL = info[UIImagePickerControllerMediaURL] as! URL
            do {
                
                //create preview picture
                let asset = AVURLAsset(url: videoURL)
                let generator = AVAssetImageGenerator(asset: asset)
                let cgImage = try generator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
                let image = UIImage(cgImage: cgImage)
                let data = UIImagePNGRepresentation(image)
                
                let video = try Data(contentsOf: videoURL, options: .mappedIfSafe)
                let paths = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
                
                //Get the current time for use
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyMMDDhhmmss"
                let str = dateFormatter.string(from: date)
                
                let outputURL = paths.appendingPathComponent("movie\(str).mov")
                
                try video.write(to: outputURL!)
                
                let videoData = Video(video: outputURL?.absoluteString, pic: data, context: stack.context)
                videoData.location = JournalInfo.location
                print(videoData)
                save() 
                
            } catch {
                print(error)
                return
            }
            
            
        }
    
        dismiss(animated: true, completion: nil)

        
    }


    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
}

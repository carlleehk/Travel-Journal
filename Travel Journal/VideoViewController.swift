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

class VideoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takingVideo(_ sender: Any) {
        pickingVideo(sourceType: UIImagePickerControllerSourceType.camera)
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


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

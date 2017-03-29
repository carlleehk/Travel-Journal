//
//  PictureViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/25/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickingPicture(sourceType: UIImagePickerControllerSourceType){
        let image = UIImagePickerController()
        image.sourceType = sourceType
        image.delegate = self
        present(image, animated: true, completion: nil)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        pickingPicture(sourceType: UIImagePickerControllerSourceType.camera)
    }

    @IBAction func Album(_ sender: Any) {
        pickingPicture(sourceType: UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func FlickR(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "pictureCollection") as! PictureViewCollectionViewController
        present(control, animated: true, completion: nil)
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

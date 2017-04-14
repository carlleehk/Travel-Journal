//
//  PictureViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/25/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

class PictureViewController: ChooseScreenViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func pickingPicture(sourceType: UIImagePickerControllerSourceType){
        let image = UIImagePickerController()
        image.sourceType = sourceType
        image.delegate = self
        present(image, animated: true, completion: nil)
    }
    
    @IBAction func takePicture(_ sender: Any) {
        
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let alertController = UIAlertController(title: "Error", message: "Camera is not avaliable for use, please choose other sosurce.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        } else{
            pickingPicture(sourceType: UIImagePickerControllerSourceType.camera)
        }
        
    }

    @IBAction func Album(_ sender: Any) {
        pickingPicture(sourceType: UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func FlickR(_ sender: Any) {
        let control = storyboard?.instantiateViewController(withIdentifier: "pictureCollection") as! PictureViewCollectionViewController
        present(control, animated: true, completion: nil)
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagePick = info[UIImagePickerControllerOriginalImage] as? UIImage{
            
            let data = UIImagePNGRepresentation(imagePick)
            let imageData = Photo(photo: data!, context: stack.context)
            imageData.location = JournalInfo.location
            print(imageData)
            save()
            
        }
        
        dismiss(animated: true, completion: nil)
    }


}

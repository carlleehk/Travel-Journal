//
//  TextEditorViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/28/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

class TextEditorViewController: UIViewController, UITextViewDelegate{

    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        //set up keyboard
        //NotificationCenter.default.addObserver(self, selector: #selector(TextEditorViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //NotificationCenter.default.addObserver(self, selector: #selector(TextEditorViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
       
    func textViewDidBeginEditing(_ textView: UITextView) {
        textField.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textField.resignFirstResponder()
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y += 50
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y -= 50
                self.view.frame.origin.y += keyboardSize.height
            }
        }
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

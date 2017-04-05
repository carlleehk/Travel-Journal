//
//  TextEditorViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/28/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit

class TextEditorViewController: ChooseScreenViewController, UITextViewDelegate{

    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }

    @IBAction func Done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
       
    func textViewDidBeginEditing(_ textView: UITextView) {
        textField.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textField.resignFirstResponder()
        let detailJ = DetailedJournal(pic: nil, video: nil, detailJ: textField.text, context: stack.context)
        detailJ.location = JournalInfo.location
        save()
        print(detailJ)
        
    }

}

//
//  TextEditorViewController.swift
//  Travel Journal
//
//  Created by Carl Lee on 3/28/17.
//  Copyright © 2017 Carl Lee. All rights reserved.
//

import UIKit
import CoreData

class TextEditorViewController: ChooseScreenViewController, UITextViewDelegate{

    @IBOutlet weak var textField: UITextView!
    
    let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        fr.sortDescriptors = []
        fr.predicate = NSPredicate(format: "location = %@", argumentArray: [JournalInfo.location])
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
        if fetchedResultsController?.fetchedObjects?.count != 0{
            let journal = fetchedResultsController?.fetchedObjects?[0] as! Note
            textField.text = journal.notes!
        }
    }

    @IBAction func Done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
       
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (fetchedResultsController?.fetchedObjects?.count == 0) {
            textField.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textField.resignFirstResponder()
        if (fetchedResultsController?.fetchedObjects?.count == 0) {
            let detailJ = Note(detailJ: textField.text, context: stack.context)
            detailJ.location = JournalInfo.location
        } else{
            let object = fetchedResultsController?.fetchedObjects?[0] as! Note
            object.setValue(textField.text, forKey: "notes")
        }
        save()
        
        
    }

}
